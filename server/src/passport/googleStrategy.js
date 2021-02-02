const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth').OAuth2Strategy;
const User = require('../models/User');
const { MONGOOSE_GOOGLE_KEY } = require('../config/googleConfig');
const { GOOGLE_PASSPORT_CONFIG } = require('../config/googleConfig');
const { getUserFromSessionId } = require('../utils/connectSessionHelper');

const STRATEGY_GOOGLE = 'google';

passport.use(new GoogleStrategy(GOOGLE_PASSPORT_CONFIG,
    async function (req, accessToken, refreshToken, profile, cb) {
        const user = await getUserFromSessionId(req.query.state || '', 'google');

        if (!user) {
            return cb(null, false);
        }

        try {
            user.connectData.set(MONGOOSE_GOOGLE_KEY, { refreshToken: refreshToken });
            await User.findByIdAndUpdate(user._id, user);

            return cb(null, user);
        } catch (e) {
            return cb(null, false);
        }
    }
));

module.exports = {
    STRATEGY_GOOGLE
}