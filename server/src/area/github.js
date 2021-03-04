const { graphql } = require("@octokit/graphql");

const Area = require('../models/Area');
const User = require('../models/User');
const githubService = require('../services/githubService');
const { MONGOOSE_GITHUB_KEY } = require('../config/githubConfig');

const graphqlRepositoryCount = (owner, _) => `{
    repositoryOwner(login:"${owner}") {
        repositories {
            totalCount
        }
    }
}`;

const graphqlOpenedIssues = (owner, name) => `{
    repository(owner:"${owner}", name:"${name}") {
        issues(states:OPEN) {
            totalCount
        }
    }
}`;

const graphqlClosedIssues = (owner, name) => `{
    repository(owner:"${owner}", name:"${name}") {
        issues(states:CLOSED) {
            totalCount
        }
    }
}`;

const graphqlPullRequests = (owner, name) => `{
    repository(owner:"${owner}", name:"${name}") {
        pullRequests {
            totalCount
        }
    }
}`;

const graphqlRefsCount = (owner, name) => `{
    repository(owner:"${owner}", name:"${name}") {
        refs(refPrefix: "refs/heads/") {
            totalCount
        }
    }
}`;

const graphqlTagCount = (owner, name) => `{
    repository(owner:"${owner}", name:"${name}") {
        refs(refPrefix: "refs/tags/") {
            totalCount
        }
    }
}`;

const QUERIES = {
    'new_repository': graphqlRepositoryCount,
    'new_issue': graphqlOpenedIssues,
    'issue_closes': graphqlClosedIssues,
    'new_pull_request': graphqlPullRequests,
    'new_ref': graphqlRefsCount,
    'new_tag': graphqlTagCount
}

async function execQuery(area, user, graphQuery, react) {
    const connectData = user.connectData.get(MONGOOSE_GITHUB_KEY);
    const { data } = area.action;
    let count = undefined;

    if (!connectData) {
        return "Not connected to github";
    }
    try {
        const graphResult = await graphql(graphQuery(data.owner, data.repo), {
            headers: {
                authorization: `Bearer ${connectData.accessToken}`,
            },
        });

        /* data be like
            { repository: { issues:       { totalCount: number } } } new_issue
            { repository: { issues:       { totalCount: number } } } issue_closes
            { repository: { pullRequests: { totalCount: number } } } new_pull_request
            { user:       { repositories: { totalCount: number } } } new_repository
            du coup je fais un trick pour ne pas à faire des ifs or something
        */
        for (const obj in graphResult) {
            if (graphResult.hasOwnProperty(obj)) {
                const res = graphResult[obj];
                for (const data in res) {
                    if (res.hasOwnProperty(data))
                        count = res[data].totalCount;
                }
            }
        }
    } catch (err) {
        console.log(err);
        return "Could not process query";
    }
    if (count === undefined) {
        // TODO: est-ce que y'a besoin de faire une gestion d'erreur en mode le repo a été supprimé donc il faut del l'AREA
        return "Could not find any count in query response";
    }
    console.log({ count, data: data.currentCount });
    if (count !== data.currentCount) {
        if (count > data.currentCount) { // TODO: devrait proc plusieures fois si jamais il y a plusieurs issues en même temps
            area.action.data.currentCount = count;
            await Area.findByIdAndUpdate(area._id, area);
            react(area);
        } else {
            area.action.data.currentCount = count;
            await Area.findByIdAndUpdate(area._id, area);
        }
    }
    return false;
}

async function githubTriggers(area, react) {
    const user = await User.findById(area.userId);
    const query = QUERIES[area.action.name];

    console.log(area.action.name);
    if (query) {
        await execQuery(area, user, query, react);
    }
}

async function githubReact(area) {
    const user = await User.findById(area.userId);

    if (area.reaction.name === "open_issue") {
        const data = githubService.getUserData(user);

        try {
            await githubService.postNewIssue(area.reaction.data, data.accessToken);
        } catch (err) {
            console.log(err);
        }
    }
}

async function githubCheck(action) {
    const query = QUERIES[area.action.name];

    if (query) {
        return await execQuery({ action }, user, query, react);
    }
    return "Could not find query from action name (not supposed to happen)";
}

module.exports = {
    githubTriggers,
    githubReact,
    githubCheck
};
