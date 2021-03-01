const express = require('express');

const protectedRequest = require('../passport/protectedRequest');
const User = require('../models/User');
const Area = require('../models/Area');
const AREA_SERVICES = require('../services');

const router = express.Router();

/**
 * @swagger
 *
 * /areas:
 *   post:
 *     summary: Create areas.
 *      responses:
 *        201:
 *          description: Area created.
 *        400:
 *          description: Action or Reaction service does not exist.
 *        401:
 *          description: Action or Reaction does not exist.
 *        500:
 *          description: Error.
 */
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
        return res.status(401).send('Action does not exist');
    }
    if (!reactionName) {
        return res.status(401).send('Reaction does not exist');
    }

    try {
        const newArea = await Area.create({
            userId: user._id,
            action: req.body.action,
            reaction: req.body.reaction
        });
    } catch(err) {
        console.log(err);
        return res.status(400).send('Area creation failed');
    }
    return res.sendStatus(201);
});

/**
 * @swagger
 *
 * /areas:
 *   put:
 *     summary: Update area by id.
 *      responses:
 *        200:
 *          description: Area updated.
 *        400:
 *          description: Could not update Area.
 *        500:
 *          description: Error.
 */
router.put('/:id', protectedRequest, async (req, res) => {
    try {
        await Area.findByIdAndUpdate(req.params.id, { action: req.body.action, reaction: req.body.reaction });
    } catch (err) {
        console.log(err);
        return res.status(400).send('Could not update Area');
    }
    return res.sendStatus(200);
})

/**
 * @swagger
 *
 * /areas:
 *   delete:
 *     summary: Delete area by id.
 *      responses:
 *        204:
 *          description: Area deleted.
 *        400:
 *          description: Could not delete Area.
 *        500:
 *          description: Error.
 */
router.delete('/:id', protectedRequest, async (req, res) => {
    try {
        await Area.findByIdAndDelete(req.params.id);
    } catch (err) {
        console.log(err);
        return res.status(400).send('Could not delete Area');
    }
    return res.sendStatus(204);
})

/**
 * @swagger
 *
 * /areas:
 *   get:
 *     summary: Get all Areas of the user.
 *      responses:
 *        200:
 *          description: Areas list sent.
 *        400:
 *          description: Could not send Areas list.
 *        500:
 *          description: Error.
 */
router.get('/', protectedRequest, async (req, res) => {
    const { user } = req;

    const areas = await Area.find({ userId: user._id });
    let areasList = [];

    for (const area of areas) {
        areasList.push({ id: area.id, action: area.action, reaction: area.reaction });
    }
    return res.send(areasList);
});

module.exports = router;
