const Twitter = require('twitter');

const { MONGOOSE_TWITTER_KEY, TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET } = require('../config/twitterConfig');

function getUserData(user) {
    const connectData = user.connectData.get(MONGOOSE_TWITTER_KEY);

    if (!connectData) {
        return null;
    }
    return connectData;
}

function postTweet(accessToken, accessTokenSecret, tweet) {
    const client = new Twitter({
        consumer_key: TWITTER_CONSUMER_KEY,
        consumer_secret: TWITTER_CONSUMER_SECRET,
        access_token_key: accessToken,
        access_token_secret: accessTokenSecret
    });
    const date = new Date();
    const hour = date.getUTCHours();
    const minutes = date.getUTCMinutes();
    const seconds = date.getUTCSeconds();
    const actualHour = hour + 1;

    client.post('/statuses/update', { status: tweet + ', at ' + actualHour + ':' + minutes + ':' + seconds }, (err) => {
        if (err) {
            console.log(err);
            return false;
        }
    });
    return true;
}

function updateRequest(client, description, name) {
    const date = new Date();
    const hour = date.getUTCHours();
    const minutes = date.getUTCMinutes();
    const seconds = date.getUTCSeconds();
    const actualHour = hour + 1;
    const params = {
        name: name,
        description: description + ', at ' + actualHour + ':' + minutes + ':' + seconds
    }
    client.post('/account/update_profile.json', params, (err) => {
        if (err) {
            console.log(err);
            return false;
        }
    });
    return true
}

function updateDescription(accessToken, accessTokenSecret, description) {
    const client = new Twitter({
        consumer_key: TWITTER_CONSUMER_KEY,
        consumer_secret: TWITTER_CONSUMER_SECRET,
        access_token_key: accessToken,
        access_token_secret: accessTokenSecret
    });
    client.get('/account/settings.json', {}, (err, tweets, response) => {
        if (err) {
            console.log(err);
            return false;
        }
        const name = JSON.parse(response.body).screen_name;
        const request = updateRequest(client, description, name);

        if (request === false) {
            return false;
        }
    });
    return true;
}

module.exports = {
    getUserData,
    postTweet,
    updateDescription
}