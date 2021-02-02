const express = require('express');
const passport = require('passport');
const protectedRequest = require('../passport/protectedRequest');
const { STRATEGY_GOOGLE } = require('../passport/googleStrategy');
const { STRATEGY_GITHUB } = require('../passport/githubStrategy');
const { STRATEGY_DISCORD } = require('../passport/discordStrategy');
const DiscordOAuth = require('discord-oauth2');

const { CLIENT_WEB_URI } = require('../config/config');
const { MSAL_SCOPES, MSAL_REDIRECT_URI, MONGOOSE_MSAL_KEY } = require('../config/msalConfig');
const { DISCORD_CLIENT_ID, DISCORD_CLIENT_SECRET } = require('../config/discordConfig');
const User = require('../models/User');
const { createConnectSession, getUserFromSessionId } = require('../utils/connectSessionHelper');

const router = express.Router();

const connectSessionMicrosoft = 'microsoft';
const connectSessionGoogle = 'google';
const connectSessionGithub = 'github';
const connectSessionDiscord = 'discord';

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
router.get('/google', protectedRequest, async (req, res, next) => {
    const connectSessionId = await createConnectSession(req.user._id, connectSessionGoogle);
    const urlDeGrosChad = `https://accounts.google.com/o/oauth2/v2/auth?access_type=offline&prompt=consent&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fconnect%2Fgoogle%2Fcallback&scope=email%20profile%20openid%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fyoutube.readonly&state=${connectSessionId}&client_id=355270370316-80n2ips385e7p1pksh60ndl8boq071lk.apps.googleusercontent.com`;

    return res.json({url: urlDeGrosChad});
});

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
        session: false,
        scope:
            [ 'email', 'profile', 'openid', 'https://www.googleapis.com/auth/youtube.readonly' ],
        accessType: 'offline',
        successRedirect: CLIENT_WEB_URI + '/home',
        failureRedirect: CLIENT_WEB_URI + '/yes'
    })(req, res, next);
});

/**
 * @swagger
 *
 * /connect/github:
 *   get:
 *     summary: Login to Github service.
 *     responses:
 *       302:
 *         description: Redirects to Github login page. On error, redirects to home page.
 *       401:
 *         description: Not authenticated to the app.
 *       500:
 *         description: Error.
 */
router.get('/github', protectedRequest, async (req, res, next) => {
    const connectSessionId = await createConnectSession(req.user._id, connectSessionGithub);
    const urlGithub = `https://github.com/login/oauth/authorize?response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fconnect%2Fgithub%2Fcallback&scope=repo%2Cuser&state=${connectSessionId}&client_id=36fd678ea9f580199c89`;

    return res.json({ url: urlGithub });
});

/**
 * @swagger
 *
 * /connect/github/callback:
 *   get:
 *     summary: Callback used to catch Github authentication response.
 *     responses:
 *       302:
 *         description: Redirects to app home page.
 *       401:
 *         description: Not authenticated to the app.
 *       500:
 *         description: Error.
 */
router.get('/github/callback', (req, res, next) => {
    passport.authenticate(STRATEGY_GITHUB, {
        session: false,
        scope: [ 'repo', 'user' ],
        successRedirect: CLIENT_WEB_URI + '/home',
        failureRedirect: CLIENT_WEB_URI + '/home'
    })(req, res, next);
})

/**
 * @swagger
 *
 * /connect/discord:
 *   get:
 *     summary: Login to Discord service
 *     responses:
 *       302:
 *         description: Redirects to Discord login page. On error, redirects to home page.
 *       401:
 *         description: Not authenticated to the app.
 *       500:
 *         description: Error.
 */
router.get('/discord', protectedRequest, async (req, res, next) => {
    const connectSessionId = await createConnectSession(req.user._id, connectSessionDiscord);
    const targetUrl = `https://discord.com/api/oauth2/authorize?client_id=805846126397095956&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fconnect%2Fdiscord%2Fcallback&response_type=code&scope=email%20identify%20guilds%20messages.read&state=${connectSessionId}`;

    return res.json({ url: targetUrl });
})

/**
 * @swagger
 *
 * /connect/discord/callback:
 *   get:
 *     summary: Callback used to catch Discord authentication response and get credentials
 *     responses:
 *       302:
 *         description: Redirects to home page.
 *       401:
 *         description: Not authenticated to the app.
 *       500:
 *         description: Error.
 */
router.get('/discord/callback', (req, res, next) => {
    console.log(req.query.code);
    passport.authenticate(STRATEGY_DISCORD, {
        session: false,
        scope: [ 'guilds', 'messages.read', 'identify', 'email' ],
        successRedirect: CLIENT_WEB_URI + '/home',
        failureRedirect: CLIENT_WEB_URI + '/home'
    })(req, res, next);
})

module.exports = router;
