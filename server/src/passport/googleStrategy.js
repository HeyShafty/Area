const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth').OAuth2Strategy;
const User = require('../models/User');

const { MONGOOSE_GOOGLE_KEY } = require('../config/googleConfig');
const { GOOGLE_PASSPORT_CONFIG_WEB, GOOGLE_PASSPORT_CONFIG_MOBILE } = require('../config/googleConfig');

const STRATEGY_GOOGLE_WEB = 'google-web';
const STRATEGY_GOOGLE_MOBILE = 'google-mobile';

async function googleStrategy(req, accessToken, refreshToken, profile, cb) {
    try {
        const user = req.user;

        user.connectData.set(MONGOOSE_GOOGLE_KEY, { refreshToken: refreshToken });
        await User.findByIdAndUpdate(user._id, user);
        return cb(null, true);
    } catch (e) {
        return cb(null, false);
    }
}

passport.use(STRATEGY_GOOGLE_WEB, new GoogleStrategy(GOOGLE_PASSPORT_CONFIG_WEB, googleStrategy));
passport.use(STRATEGY_GOOGLE_MOBILE, new GoogleStrategy(GOOGLE_PASSPORT_CONFIG_MOBILE, googleStrategy));

module.exports = {
    STRATEGY_GOOGLE_WEB,
    STRATEGY_GOOGLE_MOBILE
}
