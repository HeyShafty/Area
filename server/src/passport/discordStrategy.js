const passport = require('passport');
const DiscordStrategy = require('passport-discord').Strategy;
const User = require('../models/User');
const { DISCORD_PASSPORT_CONFIG, MONGOOSE_DISCORD_KEY } = require('../config/discordConfig');
const { getUserFromSessionId } = require('../utils/connectSessionHelper');

const STRATEGY_DISCORD = 'discord';

passport.use(new DiscordStrategy(DISCORD_PASSPORT_CONFIG,
    async function (req, accessToken, refreshToken, profile, done) {
        const user = await getUserFromSessionId(req.query.state || '', 'discord');

        if (!user) {
            return done(null, false);
        }

        try {
            user.connectData.set(MONGOOSE_DISCORD_KEY, { accessToken: accessToken });
            await User.findByIdAndUpdate(user._id, user);

            return done(null, user);
        } catch (e) {
            return done(null, false);
        }
    }
));

module.exports = {
    STRATEGY_DISCORD
}