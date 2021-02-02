const DISCORD_CLIENT_ID = '805846126397095956';
const DISCORD_CLIENT_SECRET = '6g42_M2zOrT1ZuFNv-VaEnz87ahuQfyf';
const DISCORD_CALLBACK = 'http://localhost:8080/connect/discord/callback';
const MONGOOSE_DISCORD_KEY = 'discord';

const DISCORD_PASSPORT_CONFIG = {
    clientID: DISCORD_CLIENT_ID,
    clientSecret: DISCORD_CLIENT_SECRET,
    callbackURL: DISCORD_CALLBACK,
    passReqToCallback: true
};

module.exports = {
    DISCORD_CLIENT_ID,
    DISCORD_CLIENT_SECRET,
    DISCORD_CALLBACK,
    DISCORD_PASSPORT_CONFIG,
    MONGOOSE_DISCORD_KEY
};