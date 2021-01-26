const passport = require('passport');
const express = require('express');
const jwt = require('jsonwebtoken');

const isLoggedIn = require("../passport/isLoggedIn");
const { JWT_SECRET_KEY } = require('../config/jwtConfig')
const { STRATEGY_OFFICE_JWT } = require("../passport/officeJwtStrategy");
const { STRATEGY_LOCAL_SIGN_IN, STRATEGY_LOCAL_SIGN_UP } = require('../passport/localStrategy');
const { STRATEGY_JWT } = require('../passport/jwtStrategy');

const router = express.Router();

/**
 * @swagger
 *
 * /auth/ping:
 *   get:
 *     summary: Checks if current session is valid.
 *     responses:
 *       200:
 *         description: Authenticated.
 *         content:
 *           text/plain:
 *             schema:
 *               type: boolean
 *       401:
 *         description: Invalid session.
 */
router.get('/ping', isLoggedIn, (req, res) => {
    res.send(true);
});

/**
 * @swagger
 *
 * /auth/sign-in:
 *   post:
 *      summary: Authenticate to the application.
 *      produces:
 *        - application/json
 *      parameters:
 *        - name: email
 *          description: User email.
 *          in: formData
 *          required: true
 *          type: string
 *        - name: password
 *          description: User password.
 *          in: formData
 *          required: true
 *          type: string
 *      responses:
 *        200:
 *          description: Authenticated.
 *          content:
 *            application/json:
 *              schema:
 *                type: object
 *                properties:
 *                  token:
 *                    type: string
 *        401:
 *          description: Cannot find email or password.
 *        409:
 *          description: Wrong credentials.
 *        500:
 *          description: Error.
 */
router.post('/sign-in', (req, res, next) => {
    passport.authenticate(STRATEGY_LOCAL_SIGN_IN, (err, user, info) => {
        if (err) {
            console.log(err);
            return res.sendStatus(500);
        }
        if (!user) {
            if (info.hasOwnProperty('code') && info.hasOwnProperty('message')) {
                return res.status(info.code).json({ message: info.message });
            } else {
                return res.sendStatus(400);
            }
        }
        req.logIn(user, { session: false }, (err) => {
            if (err) {
                return next(err);
            }
            const body = { email: user.email, displayName: user.displayName };
            const token = jwt.sign({ user: body }, JWT_SECRET_KEY, { expiresIn: '2 years' });

            res.json({ token });
        })
    })(req, res, next);
});

/**
 * @swagger
 *
 * /auth/sign-up:
 *   post:
 *     summary: Register to the application.
 *     produces:
 *       - application/json
 *     parameters:
 *       - name: email
 *         description: User email.
 *         in: formData
 *         required: true
 *         type: string
 *       - name: password
 *         description: User password.
 *         in: formData
 *         required: true
 *         type: string
 *       - name: fullName
 *         in: formData
 *         required: true
 *         type: string
 *         description: Username.
 *     responses:
 *       200:
 *         description: Registered and authenticated.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 token:
 *                   type: string
 *       400:
 *         description: Cannot find email or password or fullName.
 *       409:
 *         description: A user with the given email already exists.
 *       500:
 *         description: Error.
 */
router.post('/sign-up', (req, res, next) => {
    passport.authenticate(STRATEGY_LOCAL_SIGN_UP, (err, user, info) => {
        if (err) {
            console.log(err);
            return res.sendStatus(500);
        }
        if (!user) {
            if (info.hasOwnProperty('code') && info.hasOwnProperty('message')) {
                return res.status(info.code).json({ message: info.message });
            } else {
                return res.sendStatus(400);
            }
        }
        req.logIn(user, { session: false }, (err) => {
            if (err) {
                return next(err);
            }
            const body = { email: user.email, displayName: user.displayName };
            const token = jwt.sign({ user: body }, JWT_SECRET_KEY, { expiresIn: '2 years' });

            res.json({ token });
        });
    })(req, res, next);
});

/**
 * @swagger
 *
 * /auth/office-jwt:
 *   get:
 *     summary: Sign-in or sign-up to the app using a Microsoft Azure OAuth 2.0 token.
 *     parameters:
 *       - in: header
 *         name: Authorization
 *         required: true
 *     responses:
 *       200:
 *         description: Authenticated.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 token:
 *                   type: string
 *       400:
 *         description: Missing token or bad token.
 *       500:
 *         description: Error.
 */
router.post('/office-jwt', (req, res, next) => {
    passport.authenticate(STRATEGY_OFFICE_JWT, (err, user) => {
        if (err) {
            return res.sendStatus(500);
        }
        if (!user) {
            return res.sendStatus(400);
        }
        req.logIn(user, { session: false }, err => {
            if (err) {
                return next(err);
            }
            const body = { email: user.email, displayName: user.displayName };
            const token = jwt.sign({ user: body }, JWT_SECRET_KEY, { expiresIn: '2 years' });

            res.json({ token });
        });
    })(req, res, next);
});

router.get('/protected', passport.authenticate(STRATEGY_JWT, { session: false }),
    (req, res) => {
        const { user } = req;

        res.status(200).send({ user });
    }
);

/**
 * @swagger
 *
 * /auth/logout:
 *   get:
 *     summary: Ends session.
 *     responses:
 *       302:
 *         description: Session ended, redirecting to login page.
 */
router.get('/logout', (req, res) => {
    req.logout();
    // res.redirect(CLIENT_WEB_URI + '/auth/login'); // TODO: Watch out for the path
    res.sendStatus(200);
});

module.exports = router;
