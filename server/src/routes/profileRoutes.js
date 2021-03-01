const express = require('express');
const passport = require('passport');
const protectedRequest = require('../passport/protectedRequest');
const User = require('../models/User');
const bcrypt = require('bcrypt');

const router = express.Router();

router.get('/', protectedRequest, (req, res) => {
    let connectData = req.user.connectData;
    let formattedConnectData = [];

    for (const [ k ] of connectData) {
        formattedConnectData.push(k);
    }
    res.send({ displayName: req.user.displayName, email: req.user.email, services: formattedConnectData, isMicrosoftAuthed: req.user.isMicrosoftAuthed });
});

router.put('/', protectedRequest, async (req, res) => {
    const { user } = req;

    try {
        await User.findByIdAndUpdate(user._id, { displayName: req.body.username, email: req.body.email });
    } catch (err) {
        console.log(err);
        return res.status(400).send("Can't edit username");
    }
    return res.sendStatus(200);
})

router.put('/password', protectedRequest, async (req, res) => {
    const { user } = req;

    if (user.isMicrosoftAuthed === true) {
        return res.status(403).send('You are connected using Microsoft');
    }
    try {
        let pwd = await bcrypt.hash(req.body.password, 10);

        await User.findByIdAndUpdate(user._id, { password: pwd})
    } catch (err) {
        console.log(err);
        return res.status(400).send("Can't edit password");
    }
    return res.sendStatus(200);
})

module.exports = router;
