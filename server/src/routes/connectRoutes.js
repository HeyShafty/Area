const express = require('express');
const passport = require('passport');
const protectedRequest = require('../passport/protectedRequest');
const { STRATEGY_GOOGLE } = require('../passport/googleStrategy');
const { STRATEGY_GITHUB } = require('../passport/githubStrategy');

const { CLIENT_WEB_URI } = require('../config/config');
const { MSAL_SCOPES, MSAL_REDIRECT_URI, MONGOOSE_MSAL_KEY } = require('../config/msalConfig');
const User = require('../models/User');
const { createConnectSession, getUserFromSessionId } = require('../utils/connectSessionHelper');

const router = express.Router();

const connectSessionMicrosoft = 'microsoft';

router.get('/microsoft', protectedRequest, async (req, res) => {
    const connectSessionId = await createConnectSession(req.user._id, connectSessionMicrosoft);
    const urlParameters = {
        scopes: [ 'profile', 'openid', 'offline_access', 'email', 'Mail.Read', 'Calendars.Read', 'User.Read', 'MailboxSettings.Read' ],
        redirectUri: 'http://localhost:8080/connect/microsoft/callback',
        prompt: 'select_account',
        state: connectSessionId
    };

    try {
        const authUrl = await req.app.locals.msalClient.getAuthCodeUrl(urlParameters);

        res.json({ url: authUrl });
    } catch (err) {
        console.log(err);
        res.sendStatus(500);
    }
});

router.get('/microsoft/callback', async (req, res) => {
    const tokenRequest = {
        code: req.query.code,
        scopes: [ 'profile', 'openid', 'offline_access', 'email', 'Mail.Read', 'Calendars.Read', 'User.Read', 'MailboxSettings.Read' ],
        redirectUri: 'http://localhost:8080/connect/microsoft/callback'
    };
    const user = await getUserFromSessionId(req.query.state || '', connectSessionMicrosoft);

    if (!user) {
        return res.status(400).send('Invalid state');
    }
    try {
        const response = await req.app.locals.msalClient.acquireTokenByCode(tokenRequest);

        user.connectData.set(MONGOOSE_MSAL_KEY, {
            accessToken: response.accessToken,
            data: { homeAccountId: response.account.homeAccountId }
        });
        await User.findByIdAndUpdate(user._id, user);
    } catch (err) {
        console.log(err)
    }
    return res.redirect(CLIENT_WEB_URI + '/profile');
});

/**
 * @swagger
 *
 * /connect/google:
 *   get:
 *     summary: Login to Google service.
 *     responses:
 *       302:
 *         description: Redirects to Google login page. On error, redirects to app home page.
 *       401:
 *         description: Not authenticated to the app.
 *       500:
 *         description: Error.
 */
router.get('/google', passport.authenticate(STRATEGY_GOOGLE, {
    scope: [ 'email', 'profile', 'openid', 'https://www.googleapis.com/auth/youtube.readonly' ],
    accessType: 'offline',
    prompt: 'consent',
    failureRedirect: CLIENT_WEB_URI + '/home',
    state: 'le pas de calais'
}));

/**
 * @swagger
 *
 * /connect/google/callback:
 *   get:
 *     summary: Callback used to catch Google authentication response.
 *     responses:
 *       302:
 *         description: Redirects to app home page.
 *       401:
 *         description: Not authenticated to the app.
 *       500:
 *         description: Error.
 */
router.get('/google/callback', (req, res, next) => {
    passport.authenticate(STRATEGY_GOOGLE, {
        scope:
            [ 'email', 'profile', 'openid', 'https://www.googleapis.com/auth/youtube.readonly' ],
        accessType: 'offline',
        successRedirect: CLIENT_WEB_URI + '/home',
        failureRedirect: CLIENT_WEB_URI + '/yes'
    })(req, res, next);
});

router.get('/github', (req, res, next) => {
    passport.authenticate(STRATEGY_GITHUB, {
        scope: [ 'repo', 'user' ],
        failureRedirect: CLIENT_WEB_URI + '/home',
        state: 'lets go les gars'
    })(req, res, next);
});

router.get('/github/callback', (req, res, next) => {
    passport.authenticate(STRATEGY_GITHUB, {
        scope: [ 'repo', 'user' ],
        successRedirect: CLIENT_WEB_URI + '/home',
        failureRedirect: CLIENT_WEB_URI + '/fail'
    })(req, res, next);
})

module.exports = router;
