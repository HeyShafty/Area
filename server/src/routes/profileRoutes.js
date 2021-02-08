const express = require('express');
const passport = require('passport');
const protectedRequest = require('../passport/protectedRequest');

const router = express.Router();

router.get('/', protectedRequest, (req, res) => {
    let connectData = req.user.connectData;
    let formattedConnectData = [];

    for (const [ k ] of connectData) {
        formattedConnectData.push(k);
    }
    res.send({ displayName: req.user.displayName, email: req.user.email, connectData: formattedConnectData });
});

module.exports = router;
