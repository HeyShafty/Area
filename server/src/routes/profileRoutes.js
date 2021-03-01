const express = require('express');
const passport = require('passport');
const protectedRequest = require('../passport/protectedRequest');
const User = require('../models/User');

const router = express.Router();

router.get('/', protectedRequest, (req, res) => {
    res.send({ displayName: req.user.displayName, email: req.user.email, services: req.user.connectData });
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

module.exports = router;
