const express = require('express');

const protectedRequest = require('../passport/protectedRequest');
const User = require('../models/User');
const Area = require('../models/Area');

const router = express.Router();

router.post('/new', protectedRequest, async (req, res) => {
    const { user } = req;

    const newArea = await Area.create({
        userId: user._id,
        action: {
            service: 'timer',
            name: 'every_hour',
            data: {
                minute: parseInt(req.query.minute, 10)
            }
        },
        reaction: {
            service: 'microsoft',
            name: 'send_mail',
            data: {
                to: 'nathan.lecorchet@epitech.eu',
                body: 'Le pas de calais'
            }
        }
    });
    console.log(newArea);
    return res.sendStatus(200);
});

router.get('/', protectedRequest, async (req, res) => {
    const { user } = req;

    const areas = await Area.find({ userId: user._id });
    let areasList = [];

    for (const area of areas) {
        areasList.push({ actionService: area.action.service, actionName: area.action.name, reactionService: area.reaction.service, reactionName: area.reaction.name });
    }
    return res.send(areasList);
})

module.exports = router;
