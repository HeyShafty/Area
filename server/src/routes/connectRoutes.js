const express = require('express');
const isLoggedIn = require("../passport/isLoggedIn");
const passport = require('passport');
const User = require('../models/User');
const { CLIENT_WEB_URI } = require('../config/config');
const { STRATEGY_GOOGLE } = require('../passport/googleStrategy');
require('../passport/googleStrategy');

const router = express.Router();

// router.get('/microsoft', isLoggedIn, async (req, res) => {
//     try {
//
//     } catch (err) {
//         console.log(err);
//         res.redirect('/'); // TODO: front home page.
//     }
// });

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
router.get('/google', isLoggedIn, passport.authenticate(STRATEGY_GOOGLE, {
    scope: [ 'email', 'profile', 'openid', 'https://www.googleapis.com/auth/youtube.readonly' ],
    accessType: 'offline',
    prompt: 'consent',
    failureRedirect: CLIENT_WEB_URI + '/home'
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
router.get('/google/callback', isLoggedIn, passport.authenticate(STRATEGY_GOOGLE, {
    scope:
        [ 'email', 'profile', 'openid', 'https://www.googleapis.com/auth/youtube.readonly' ],
    accessType: 'offline',
    successRedirect: CLIENT_WEB_URI + '/home',
    failureRedirect: CLIENT_WEB_URI + '/home'
}));

module.exports = router;
