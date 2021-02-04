const express = require('express');
const passport = require('passport');
const protectedRequest = require('../passport/protectedRequest');
const { STRATEGY_GOOGLE_WEB, STRATEGY_GOOGLE_MOBILE } = require('../passport/googleStrategy');
const { STRATEGY_GITHUB } = require('../passport/githubStrategy');
const { STRATEGY_DISCORD } = require('../passport/discordStrategy');

const { CLIENT_WEB_URI } = require('../config/config');
const { MSAL_SCOPES, MSAL_REDIRECT_URI_WEB, MSAL_REDIRECT_URI_MOBILE, MONGOOSE_MSAL_KEY } = require('../config/msalConfig');
const { GOOGLE_PASSPORT_CONFIG_WEB, GOOGLE_PASSPORT_CONFIG_MOBILE, GOOGLE_SCOPES } = require('../config/googleConfig');
const User = require('../models/User');
const { createConnectSession, extractConnectSession } = require('../utils/connectSessionHelper');

const router = express.Router();

const connectSessionMicrosoft = 'microsoft';
const connectSessionGoogle = 'google';
const connectSessionGithub = 'github';
const connectSessionDiscord = 'discord';

router.get('/microsoft', protectedRequest, async (req, res) => {
    const isMobile = !!req.query.mobile;
    const connectSessionId = await createConnectSession(req.user._id, connectSessionMicrosoft, isMobile);
    const urlParameters = {
        scopes: MSAL_SCOPES,
        redirectUri: isMobile ? MSAL_REDIRECT_URI_MOBILE : MSAL_REDIRECT_URI_WEB,
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
    const { user, isMobile } = await extractConnectSession(req.query.state || '', connectSessionMicrosoft);
    const tokenRequest = {
        code: req.query.code,
        scopes: MSAL_SCOPES,
        redirectUri: isMobile ? MSAL_REDIRECT_URI_MOBILE : MSAL_REDIRECT_URI_WEB
    };

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
    if (isMobile) {
        return res.sendStatus(200);
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
router.get('/google', protectedRequest, async (req, res) => {
    const isMobile = !!req.query.mobile;
    const connectSessionId = await createConnectSession(req.user._id, connectSessionGoogle, isMobile);
    const config = isMobile ? GOOGLE_PASSPORT_CONFIG_MOBILE : GOOGLE_PASSPORT_CONFIG_WEB;
    const urlDeGrosChad = new URL('https://accounts.google.com/o/oauth2/v2/auth');

    urlDeGrosChad.searchParams.append('access_type', 'offline');
    urlDeGrosChad.searchParams.append('prompt', 'consent');
    urlDeGrosChad.searchParams.append('response_type', 'code');
    urlDeGrosChad.searchParams.append('redirect_uri', config.callbackURL);
    urlDeGrosChad.searchParams.append('scope', GOOGLE_SCOPES.join(' '));
    urlDeGrosChad.searchParams.append('state', connectSessionId);
    urlDeGrosChad.searchParams.append('client_id', config.clientID);
    return res.json({ url: urlDeGrosChad.href });
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
router.get('/google/callback', async (req, res, next) => {
    const { user, isMobile } = await extractConnectSession(req.query.state || '', connectSessionGoogle);

    if (!user) {
        return res.status(400).send('Invalid state');
    }
    req.user = user;
    passport.authenticate(isMobile ? STRATEGY_GOOGLE_MOBILE : STRATEGY_GOOGLE_WEB, (err, success) => {
        if (err || !success) {
            return res.sendStatus(500);
        }
        req.logIn(user, {
            session: false,
            scope: GOOGLE_SCOPES,
            accessType: 'offline',
            successRedirect: CLIENT_WEB_URI + '/profile',
            failureRedirect: CLIENT_WEB_URI + '/profile' // TODO: Failure redirect ?
        }, (err) => {
            if (err) {
                return next(err);
            }
            if (isMobile) {
                return res.sendStatus(200);
            }
            return res.redirect(CLIENT_WEB_URI + '/profile');
        });
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
    const urlDeGrosChad = `https://github.com/login/oauth/authorize?response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fconnect%2Fgithub%2Fcallback&scope=repo%2Cuser&state=${connectSessionId}&client_id=36fd678ea9f580199c89`;

    return res.json({ url: urlDeGrosChad });
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
        successRedirect: CLIENT_WEB_URI + '/profile',
        failureRedirect: CLIENT_WEB_URI + '/profile' // TODO: Failure redirect ?
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
    const urlDeGrosChad = `https://discord.com/api/oauth2/authorize?client_id=805846126397095956&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fconnect%2Fdiscord%2Fcallback&response_type=code&scope=email%20identify%20guilds%20messages.read&state=${connectSessionId}`;
    // const chad = 'https://discord.com/api/oauth2/authorize?client_id=805846126397095956&redirect_uri=area.app%3A%2F%2Fauth&response_type=code&scope=identify%20email%20guilds%20messages.read';

    return res.json({ url: urlDeGrosChad });
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
        successRedirect: CLIENT_WEB_URI + '/profile',
        failureRedirect: CLIENT_WEB_URI + '/profile' // TODO: Failure redirect ?
    })(req, res, next);
})

module.exports = router;
