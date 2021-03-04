const Area = require('../models/Area');
const User = require('../models/User');
const microsoftService = require('../services/microsoftService');

async function incomingMail(area, user, react, publicMsalClient, confidentialMsalClient) {
    const accessToken = await microsoftService.getUserAccessToken(user, (area.isMobile ? publicMsalClient : confidentialMsalClient));
    const { data } = area.action;
    let count = undefined;

    if (accessToken === null) {
        console.log("disconnected?");
        return;
    }
    try {
        count = await microsoftService.getInboxItemCount(accessToken);
    } catch (err) {
        console.log(err);
        // delete area?
        return;
    }
    if (count === undefined) {
        console.log('tfuck');
        return;
    }
    console.log({ count, data: data.currentCount });
    if (count !== data.currentCount) {
        if (count > data.currentCount) { // TODO: devrait proc plusieures fois si jamais il y en a plusieurs en même temps
            area.action.data.currentCount = count;
            await Area.findByIdAndUpdate(area._id, area);
            react(area);
        } else {
            area.action.data.currentCount = count;
            await Area.findByIdAndUpdate(area._id, area);
        }
    }
}

async function microsoftTriggers(area, react, publicMsalClient, confidentialMsalClient) {
    const user = await User.findById(area.userId);

    console.log(area.action);
    if (area.action.name === 'incoming_mail') {
        await incomingMail(area, user, react, publicMsalClient, confidentialMsalClient);
    }
}

module.exports = microsoftTriggers;
