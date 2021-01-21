const passport = require('passport');
const express = require('express');
const jwt = require('jsonwebtoken');

const isLoggedIn = require("../passport/isLoggedIn");
const { JWT_SECRET_KEY } = require('../config/jwtConfig')
const { STRATEGY_OFFICE_JWT } = require("../passport/officeJwtStrategy");
const { STRATEGY_LOCAL_SIGN_IN, STRATEGY_LOCAL_SIGN_UP } = require('../passport/localStrategy');
const { STRATEGY_JWT } = require('../passport/jwtStrategy');

const router = express.Router();

router.get('/ping', isLoggedIn, (req, res) => {
    res.send(true);
});

router.post('/sign-in',
    passport.authenticate(STRATEGY_LOCAL_SIGN_IN), (req, res) => {
        let user = req.user;
        const body = { email: user.email, displayName: user.displayName };
        const token = jwt.sign({ user: body }, JWT_SECRET_KEY, { expiresIn: '7 days' });

        res.json({ token });
    });

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
        req.logIn(user, (err) => {
            if (err) {
                return next(err);
            }
            const body = { email: user.email, displayName: user.displayName };
            const token = jwt.sign({ user: body }, JWT_SECRET_KEY, { expiresIn: '7 days' });

            res.json({ token });
        });
    })(req, res, next);
});

router.get('/office-jwt', (req, res, next) => {
    passport.authenticate(STRATEGY_OFFICE_JWT, (err, user) => {
        if (err) {
            return res.sendStatus(500);
        }
        if (!user) {
            return res.sendStatus(400);
        }
        req.logIn(user, err => {
            if (err) {
                return next(err);
            }
            const body = { email: user.email, displayName: user.displayName };
            const token = jwt.sign({ user: body }, JWT_SECRET_KEY, { expiresIn: '7 days' });

            res.json({ token });
        });
    })(req, res, next);
});

router.get('/protected', passport.authenticate(STRATEGY_JWT, {session: false}),
    (req,res) => {
        const { user } = req;

        res.status(200).send({ user });
    }
);

router.get('/logout', (req, res) => {
    req.logout();
    // res.redirect(CLIENT_WEB_URI + '/auth/login'); // TODO: Watch out for the path
    res.sendStatus(200);
});

module.exports = router;
