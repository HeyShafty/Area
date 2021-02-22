const Area = require('./models/Area');
const User = require('./models/User');
const timerTriggers = require('./area/timer');
const githubTriggers = require('./area/github');

const serviceGithub = require('./services/githubService');
const serviceTwitter = require('./services/twitterService');
const serviceMicrosoft = require('./services/microsoftService');

const botToken = 'ODEzMzU1Nzc1ODI1MTQ5OTYy.YDOGmA.Ee-nvgFu2v0FHo_7c6XBDd0WsgI';
const Discord = require('discord.js');
const client = new Discord.Client();

client.login(botToken);

async function doReaction(area, msalClient) {
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
    if (area.reaction.service === "microsoft") {
        if (area.reaction.name === "send_mail") {
            const accessToken = await serviceMicrosoft.getUserAccessToken(user, msalClient);
            try {
                const sendMailRequest = await serviceMicrosoft.sendEmail(accessToken, area.reaction.data.to, area.reaction.data);
            } catch (err) {
                console.log(err);
            }
        }
    }
    if (area.reaction.service === "twitter") {
        const data = await serviceTwitter.getUserData(user);
        if (area.reaction.name === "post_tweet") {
            try {
                const postTweet = serviceTwitter.postTweet(data.accessToken, data.data.oauthAccessTokenSecret, area.reaction.data.body);
            } catch (err) {
                console.log(err);
            }
        }
        if (area.reaction.name === "update_bio") {
            try {
                const updateDescription = serviceTwitter.updateDescription(data.accessToken, data.data.oauthAccessTokenSecret, area.reaction.data.body);
            } catch (err) {
                console.log(err);
            }
        }
    }
    if (area.reaction.service === "discord") {
        if (area.reaction.name === "post_message") {
            try {
                client.channels.cache.get(area.reaction.data.id).send(area.reaction.data.body);
            } catch (err) {
                console.log(err);
            }
        }
    }
}

async function checkupTriggers(msalClient) {
    const areas = await Area.find({});
    const react = (_area) => doReaction(_area, msalClient);

    // console.log(areas);
    for (const area of areas) {
        if (area.action.service === 'github') {
            await githubTriggers(area, react);
        }
        if (area.action.service === 'timer') {
            await timerTriggers(area, react);
        }
    }
}

module.exports = checkupTriggers;
