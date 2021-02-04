const express = require('express');
const passport = require('passport');
const protectedRequest = require('../passport/protectedRequest');

const router = express.Router();

router.get('/infos', protectedRequest, (req, res) => {
    res.json({ displayName: req.user.displayName, email: req.user.email, services: req.user.connectData });
});

module.exports = router;
