const Area = require('./models/Area');

async function timerTriggers(area) {
    const { data } = area.action;

    if (area.action.name === 'every_hour') {
        const date = new Date();
        const hour = date.getUTCHours();
        const minutes = date.getUTCMinutes();

        console.log(date, hour, minutes, data);
        if (data.minute === minutes && (data.lastHour === undefined || data.lastHour !== hour)) {
            area.action.data.lastHour = hour;
            await Area.findByIdAndUpdate(area._id, area);
            // await Area.updateOne(area, area); // TODO: check if better
            doReaction(area);
        }
    }
}

function doReaction(area) {
    console.log('doReaction');
    console.log(area.reaction);
}

async function checkupTriggers() {
    const areas = await Area.find({});

    console.log(areas);
    for (const area of areas) {
        if (area.action.service === 'timer') {
            await timerTriggers(area);
        }
    }
}

module.exports = checkupTriggers;
