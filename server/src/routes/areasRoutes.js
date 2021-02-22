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
})

router.get('/', protectedRequest, async (req, res) => {
    const { user } = req;

    const areas = await Area.find({ userId: user._id });
    let areasList = [];

    for (const area of areas) {
        areasList.push({ id: area.id, action: area.action, reaction: area.reaction });
    }
    return res.send(areasList);
})

// const axios = require('axios');
// const { MONGOOSE_GITHUB_KEY } = require('../config/githubConfig');

// const result = await axios.get('https://api.github.com/repos/HeyShafty/Corewar/hooks', {
//     headers: {
//         'Accept': 'application/vnd.github.v3+json',
//         'Authorization': `Bearer ${accessToken}`
//     }
// });

// router.get('/testGithub', protectedRequest, async (req, res) => {
//     const connectData = req.user.connectData.get(MONGOOSE_GITHUB_KEY);
//     let ip = '';
//
//     if (!connectData) {
//         return res.sendStatus(500);
//     }
//     try {
//         const ipRes = await axios.get('http://ipv4bot.whatismyipaddress.com/');
//
//         ip = ipRes.data;
//     } catch (e) {
//         console.log(e);
//         return res.sendStatus(500);
//     }
//     const result = await axios.post('https://api.github.com/repos/EpitechIT2020/B-YEP-500-REN-5-1-area-eliott.palueau/hooks', {
//         config: {
//             url: `http://${ip}:8080/area/calais`,
//             insecure_ssl: 1
//         },
//         events: [ 'repository', 'issues' ]
//     }, {
//         headers: {
//             'Accept': 'application/vnd.github.v3+json',
//             'Authorization': `Bearer ${connectData.accessToken}`
//         }
//     });
//     console.log(result.status);
//     console.log(result.data);
//     return res.sendStatus(200);
// });
//
// router.post('/calais', async (req, res) => {
//     console.log(req.body);
//     res.sendStatus(200);
// });

module.exports = router;
