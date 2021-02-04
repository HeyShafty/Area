const passport = require('passport');
const DiscordStrategy = require('passport-discord').Strategy;
const User = require('../models/User');

const { DISCORD_PASSPORT_CONFIG_WEB, DISCORD_PASSPORT_CONFIG_MOBILE, MONGOOSE_DISCORD_KEY } = require('../config/discordConfig');

const STRATEGY_DISCORD_WEB = 'discord-web';
const STRATEGY_DISCORD_MOBILE = 'discord-mobile';

async function discordStrategy(req, accessToken, refreshToken, profile, done) {
    try {
        const user = req.user;

        user.connectData.set(MONGOOSE_DISCORD_KEY, { accessToken: accessToken });
        await User.findByIdAndUpdate(user._id, user);
        return done(null, true);
    } catch (e) {
        return done(null, false);
    }
}

passport.use(STRATEGY_DISCORD_WEB, new DiscordStrategy(DISCORD_PASSPORT_CONFIG_WEB, discordStrategy));
passport.use(STRATEGY_DISCORD_MOBILE, new DiscordStrategy(DISCORD_PASSPORT_CONFIG_MOBILE, discordStrategy));

module.exports = {
    STRATEGY_DISCORD_WEB,
    STRATEGY_DISCORD_MOBILE
}
