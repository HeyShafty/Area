const ConnectSession = require('../models/ConnectSession');
const User = require('../models/User');

async function createConnectSession(userId, endpoint) {
    let sessionId = '';

    try {
        const createdSession = await ConnectSession.create({
            userId,
            endpoint
        });

        sessionId = createdSession._id;
    } catch (err) {
        console.log('Could not create ConnectSession for some reason...');
        console.log(err);
        return null;
    }
    return sessionId;
}

async function getUserFromSessionId(id, endpoint) {
    try {
        const connectSession = await ConnectSession.findByIdAndDelete(id);

        if (connectSession?.endpoint === endpoint) {
            return User.findById(connectSession?.userId);
        }
    } catch (err) {
        console.log('Could not verify ConnectSession for some reason...');
        console.log(err);
    }
    return null;
}

module.exports = {
    createConnectSession,
    getUserFromSessionId
};
