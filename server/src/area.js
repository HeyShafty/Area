const Area = require('./models/Area');
const User = require('./models/User');

const timerTriggers = require('./area/timer');
const githubTriggers = require('./area/github');
const youtubeTriggers = require('./area/youtube');
const microsoftTriggers = require('./area/microsoft');

const serviceGithub = require('./services/githubService');
const serviceTwitter = require('./services/twitterService');
const serviceMicrosoft = require('./services/microsoftService');
const { BOT_TOKEN } = require('./config/discordConfig');

const Discord = require('discord.js');
const client = new Discord.Client();

client.login(BOT_TOKEN);

async function doReaction(area, publicMsalClient, confidentialMsalClient) {
    const user = await User.findById(area.userId);

    if (area.reaction.service === "github") {
        if (area.reaction.name === "open_issue") {
            const data = serviceGithub.getUserData(user);
            try {
                await serviceGithub.postNewIssue(area.reaction.data, data.accessToken);
            } catch (err) {
                console.log(err);
            }
        }
    }
    if (area.reaction.service === "microsoft") {
        if (area.reaction.name === "send_mail") {
            const accessToken = await serviceMicrosoft.getUserAccessToken(user, (area.isMobile ? publicMsalClient : confidentialMsalClient));

            try {
                await serviceMicrosoft.sendEmail(accessToken, area.reaction.data.to, area.reaction.data);
            } catch (err) {
                console.log(err);
            }
        }
    }
    if (area.reaction.service === "twitter") {
        const data = await serviceTwitter.getUserData(user);
        if (area.reaction.name === "post_tweet") {
            try {
                serviceTwitter.postTweet(data.accessToken, data.data.oauthAccessTokenSecret, area.reaction.data.body);
            } catch (err) {
                console.log(err);
            }
        }
        if (area.reaction.name === "update_bio") {
            try {
                serviceTwitter.updateDescription(data.accessToken, data.data.oauthAccessTokenSecret, area.reaction.data.body);
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

async function checkupTriggers(publicMsalClient, confidentialMsalClient) {
    const areas = await Area.find({});
    const react = (_area) => doReaction(_area, publicMsalClient, confidentialMsalClient);

    for (const area of areas) {
        if (area.action.service === 'microsoft') {
            await microsoftTriggers(area, react, publicMsalClient, confidentialMsalClient);
        } else if (area.action.service === 'youtube') {
            await youtubeTriggers(area, react);
        } else if (area.action.service === 'github') {
            await githubTriggers(area, react);
        } else if (area.action.service === 'timer') {
            await timerTriggers(area, react);
        }
    }
}

module.exports = checkupTriggers;
