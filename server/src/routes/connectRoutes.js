const express = require('express');
const passport = require('passport');
const protectedRequest = require('../passport/protectedRequest');
const { STRATEGY_GOOGLE } = require('../passport/googleStrategy');

const { CLIENT_WEB_URI } = require('../config/config');
const { MSAL_SCOPES, MSAL_REDIRECT_URI } = require('../config/msalConfig');

const router = express.Router();

router.get('/microsoft', protectedRequest, async (req, res) => {
    const urlParameters = {
        scopes: [ 'profile', 'openid', 'offline_access', 'email', 'Mail.Read', 'Calendars.Read', 'User.Read', 'MailboxSettings.Read' ],
        redirectUri: 'http://localhost:8080/connect/microsoft/callback',
        prompt: 'select_account',
        state: req.user._id
    };

    try {
        const authUrl = await req.app.locals.msalClient.getAuthCodeUrl(urlParameters);

        res.json({ url: authUrl });
    } catch (err) {
        console.log(err);
        res.redirect('/'); // TODO: front home page.
    }
});

router.get('/microsoft/callback', async (req, res) => {
    const tokenRequest = {
        code: req.query.code,
        scopes: [ 'profile', 'openid', 'offline_access', 'email', 'Mail.Read', 'Calendars.Read', 'User.Read', 'MailboxSettings.Read' ],
        redirectUri: 'http://localhost:8080/connect/microsoft/callback'
    };

    try {
        console.log(req.query);
        const response = await req.app.locals.msalClient.acquireTokenByCode(tokenRequest);
        console.log(response);
        const userDetails = await microsoft.getUserDetails(response.accessToken);
        console.log(userDetails);

        req.user.microsoftConnectData = {
            isConnected: true,
            homeAccountId: response.account.homeAccountId,
            timeZone: userDetails.mailboxSettings.timeZone
        };
        // await User.updateOne({ email: req.user.email, isMicrosoftAuthed: req.user.isMicrosoftAuthed }, req.user);
    } catch (err) {
        console.log(err)
    }
    return res.redirect('http://localhost:8081' + '/home');
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
router.get('/google', (req, res, next) => {
    passport.authenticate(STRATEGY_GOOGLE, {
        scope: [ 'email', 'profile', 'openid', 'https://www.googleapis.com/auth/youtube.readonly' ],
        accessType: 'offline',
        prompt: 'consent',
        failureRedirect: CLIENT_WEB_URI + '/home',
        state: 'le pas de calais'
    })(req, res, next);
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
    console.log(req.query);
    passport.authenticate(STRATEGY_GOOGLE, {
        scope:
            [ 'email', 'profile', 'openid', 'https://www.googleapis.com/auth/youtube.readonly' ],
        accessType: 'offline',
        successRedirect: CLIENT_WEB_URI + '/home',
        failureRedirect: CLIENT_WEB_URI + '/home'
    })(req, res, next);
});

module.exports = router;
