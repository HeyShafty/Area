const express = require('express');

const protectedRequest = require('../passport/protectedRequest');
const User = require('../models/User');
const Area = require('../models/Area');
const AREA_SERVICES = require('../services');

const router = express.Router();

router.post('/', protectedRequest, async(req, res) => {
    const { user } = req;
    const actionService = AREA_SERVICES.find(service => service.name === req.body.action.service);
    const reactionService = AREA_SERVICES.find(service => service.name === req.body.reaction.service);

    if (!actionService) {
        return res.status(400).send('Action service does not exist');
    }
    if (!reactionService) {
        return res.status(400).send('Reaction service does not exist');
    }

    const actionName = actionService.actions.find(action => action.name === req.body.action.name);
    const reactionName = reactionService.reactions.find(reaction => reaction.name === req.body.reaction.name);

    if (!actionName) {
        return res.status(400).send('Action does not exist');
    }
    if (!reactionName) {
        return res.status(400).send('Reaction does not exist');
    }

    const newArea = await Area.create({
        userId: user._id,
        action: req.body.action,
        reaction: req.body.reaction
    });
    console.log(newArea);
    return res.sendStatus(200);
})

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
