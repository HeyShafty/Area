const Area = require('./models/Area');
const User = require('./models/User');
const timerTriggers = require('./area/timer');
const githubTriggers = require('./area/github');

const serviceGithub = require('./services/githubService');

async function doReaction(area) {
    const user = await User.findById(area.userId);
    console.log('doReaction');
    console.log(area.reaction);

    if (area.reaction.service === "github") {
        if (area.reaction.name === "open_issue") {
            const data = serviceGithub.getUserData(user);
            try {
                const newIssue = await serviceGithub.postNewIssue(area.reaction.data, data.accessToken);
            } catch (err) {
                console.log(err);
            }
        }
    }
}

async function checkupTriggers() {
    const areas = await Area.find({});

    // console.log(areas);
    for (const area of areas) {
        if (area.action.service === 'github') {
            await githubTriggers(area, doReaction);
        }
        if (area.action.service === 'timer') {
            await timerTriggers(area, doReaction);
        }
    }
}

module.exports = checkupTriggers;
