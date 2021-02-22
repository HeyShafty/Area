const { graphql } = require("@octokit/graphql");

const Area = require('../models/Area');
const User = require('../models/User');
const { MONGOOSE_GITHUB_KEY } = require('../config/githubConfig');

const graphqlRepositoryCount = (owner, _) => `{
    user(login:"${owner}") {
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

async function execQuery(area, user, graphQuery, react) {
    const connectData = user.connectData.get(MONGOOSE_GITHUB_KEY);
    const { data } = area.action;
    let count = undefined;

    if (!connectData) {
        // delete area ?
        return;
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
        return;
    }
    if (count === undefined) {
        console.log('tfuck'); // TODO: est-ce que y'a besoin de faire une gestion d'erreur en mode le repo a été supprimé donc il faut del l'AREA
        return;
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
}

async function githubTriggers(area, react) {
    const user = await User.findById(area.userId);

    console.log(area.action.name);
    if (area.action.name === 'new_repository') {
        await execQuery(area, user, graphqlRepositoryCount, react);
    } else if (area.action.name === 'new_issue') {
        await execQuery(area, user, graphqlOpenedIssues, react);
    } else if (area.action.name === 'issue_closes') {
        await execQuery(area, user, graphqlClosedIssues, react);
    } else if (area.action.name === 'new_pull_request') {
        await execQuery(area, user, graphqlPullRequests, react);
    }
}

module.exports = githubTriggers;
