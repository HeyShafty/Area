const axios = require('axios');

const User = require('../models/User');
const { MONGOOSE_GITHUB_KEY } = require('../config/githubConfig');

function getUserData(user) {
    const connectData = user.connectData.get(MONGOOSE_GITHUB_KEY);

    if (!connectData) {
        return null;
    }
    return connectData;
}

async function postNewIssue(data, accessToken) {
    const request = await axios.post(`https://api.github.com/repos/${data.owner}/${data.repo}/issues`,
        {
                title: data.title,
                body: data.body
        },
        {
            headers: {
                'Accept': 'application/vnd.github.v3+json',
                'Authorization': `Bearer ${accessToken}`
            }
        }
    );
    return true;
}

module.exports = {
    postNewIssue,
    getUserData
}