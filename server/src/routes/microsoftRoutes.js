const express = require('express');
const protectedRequest = require('../passport/protectedRequest');

const service = require('../services/microsoftService');

const router = express.Router();

const couldNotGetAccessToken = (res) => res.status(401).send('Could not get a new access token, please connect to Microsoft and try again.');

router.get('/me', protectedRequest, async (req, res) => {
    const accessToken = await service.getUserAccessToken(req.user, req.app.locals.msalClient);

    if (!accessToken) {
        return couldNotGetAccessToken(res);
    }
    return res.json(await service.getUserDetails(accessToken));
});

module.exports = router;
