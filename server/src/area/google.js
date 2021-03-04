const { google } = require('googleapis');
const Area = require('../models/Area');
const User = require('../models/User');
const getUserClient = require('../services/googleService');

async function newVideo(area, user, react) {
    const oauth2Client = await getUserClient(user);
    const { data } = area.action;
    let count = undefined;

    if (oauth2Client == null) {
        console.log("delete area ?");
        return;
    }
    try {
        const googleRes = await google.youtube('v3').channels.list({
            auth: oauth2Client,
            part: [
                'statistics'
            ],
            // forUsername: area.action.data.username
            id: [ data.id ]
        });

        if (!googleRes.data.items || googleRes.data.items.length === 0) {
            // no items found -> delete area ?
            return;
        }
        count = parseInt(googleRes.data.items[0].statistics.videoCount);
    } catch (err) {
        console.log(err);
        return;
    }
    console.log({ count, data: data.currentCount });
    if (count !== data.currentCount) {
        if (count > data.currentCount) { // TODO: devrait proc plusieures fois si jamais il y a plusieurs vidéos en même temps
            area.action.data.currentCount = count;
            await Area.findByIdAndUpdate(area._id, area);
            react(area);
        } else {
            area.action.data.currentCount = count;
            await Area.findByIdAndUpdate(area._id, area);
        }
    }
}

async function playlistUpdate(area, user, react) {
    const oauth2Client = await getUserClient(user);
    const { data } = area.action;
    let count = undefined;

    if (oauth2Client == null) {
        console.log("delete area ?");
        return;
    }
    try {
        const googleRes = await google.youtube('v3').playlists.list({
            auth: oauth2Client,
            part: [
                'contentDetails'
            ],
            // forUsername: area.action.data.username
            id: [ data.id ]
        });

        if (!googleRes.data.items || googleRes.data.items.length === 0) {
            // no items found -> delete area ?
            return;
        }
        count = googleRes.data.items[0].contentDetails.itemCount;
    } catch (err) {
        console.log(err);
        return;
    }
    console.log({ count, data: data.currentCount });
    if (count !== data.currentCount) {
        if (count > data.currentCount) { // TODO: devrait proc plusieures fois si jamais il y a plusieurs vidéos en même temps
            area.action.data.currentCount = count;
            await Area.findByIdAndUpdate(area._id, area);
            react(area);
        } else {
            area.action.data.currentCount = count;
            await Area.findByIdAndUpdate(area._id, area);
        }
    }
}

async function googleTriggers(area, react) {
    const user = await User.findById(area.userId);

    console.log(area.action.name);
    if (area.action.name === 'new_video') {
        await newVideo(area, user, react);
    } else if (area.action.name === 'playlist_update') {
        await playlistUpdate(area, user, react);
    }
}

module.exports = {
    googleTriggers
};
