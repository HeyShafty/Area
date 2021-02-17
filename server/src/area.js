const Area = require('./models/Area');
const timerTriggers = require('./area/timer');
const githubTriggers = require('./area/github');

function doReaction(area) {
    console.log('doReaction');
    console.log(area.reaction);
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
