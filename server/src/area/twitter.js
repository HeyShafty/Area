const twitterService = require("../services/twitterService");

async function twitterReact(area) {
    const user = await User.findById(area.userId);
    const data = await twitterService.getUserData(user);

    if (area.reaction.name === "post_tweet") {
        try {
            twitterService.postTweet(data.accessToken, data.data.oauthAccessTokenSecret, area.reaction.data.body);
        } catch (err) {
            console.log(err);
        }
    } else if (area.reaction.name === "update_bio") {
        try {
            twitterService.updateDescription(data.accessToken, data.data.oauthAccessTokenSecret, area.reaction.data.body);
        } catch (err) {
            console.log(err);
        }
    }
}

module.exports = {
    twitterReact,
};
