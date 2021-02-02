const passport = require('passport');
const GithubStrategy = require('passport-github2').Strategy;
const User = require('../models/User');
const { GITHUB_PASSPORT_CONFIG, MONGOOSE_GITHUB_KEY } = require('../config/githubConfig');
const { getUserFromSessionId } = require('../utils/connectSessionHelper');

const STRATEGY_GITHUB = 'github';

passport.use(new GithubStrategy(GITHUB_PASSPORT_CONFIG,
    async function (req, accessToken, refreshToken, profile, done) {
        const user = await getUserFromSessionId(req.query.state || '', 'github');

        if (!user) {
            return done(null, false);
        }

        try {
            user.connectData.set(MONGOOSE_GITHUB_KEY, { refreshToken: refreshToken, accessToken: accessToken });
            await User.findByIdAndUpdate(user._id, user);

            return done(null, user);
        } catch (e) {
            return done(null, false);
        }
    }
));

module.exports = {
    STRATEGY_GITHUB
}