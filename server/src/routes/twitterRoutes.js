const express = require('express');
const protectedRequest = require('../passport/protectedRequest');

const service = require('../services/twitterService');

const router = express.Router();

router.post('/tweet', protectedRequest, async (req, res) => {
    const data = service.getUserData(req.user);
    console.log(data);

    try {
        const postTweet = await service.postTweet(data.accessToken, data.data.oauthAccessTokenSecret, req.body.tweet);
        if (postTweet === true) {
            return  res.json({ status: 'Tweet sent' });
        } else {
            return res.status(400).send('Request failed');
        }
    } catch (err) {
        console.log(err);
    }
})

module.exports = router;