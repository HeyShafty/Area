const express = require('express');
const protectedRequest = require('../passport/protectedRequest');

const service = require('../services/githubService');

const router = express.Router();

router.post('/issue', protectedRequest, async (req, res) => {
    const data = service.getUserData(req.user);
    console.log(data);

    try {
        const newIssue = await service.postNewIssue(req.body.repo, req.body.data, data.accessToken);
        console.log(newIssue);
    } catch (err) {
        console.log(err);
    }
})

module.exports = router;