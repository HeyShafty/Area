const DISCORD_CLIENT_ID = '805846126397095956';
const DISCORD_CLIENT_SECRET = '6g42_M2zOrT1ZuFNv-VaEnz87ahuQfyf';
const DISCORD_SCOPES = [ 'guilds', 'messages.read', 'identify', 'email' ];
const MONGOOSE_DISCORD_KEY = 'discord';

const DISCORD_PASSPORT_CONFIG_WEB = {
    clientID: DISCORD_CLIENT_ID,
    clientSecret: DISCORD_CLIENT_SECRET,
    callbackURL: 'http://localhost:8080/connect/discord/callback',
    scope: DISCORD_SCOPES,
    passReqToCallback: true
};

const DISCORD_PASSPORT_CONFIG_MOBILE = {
    clientID: DISCORD_CLIENT_ID,
    clientSecret: DISCORD_CLIENT_SECRET,
    callbackURL: 'area.app://auth',
    scope: DISCORD_SCOPES,
    passReqToCallback: true
};

module.exports = {
    MONGOOSE_DISCORD_KEY,
    DISCORD_SCOPES,
    DISCORD_PASSPORT_CONFIG_WEB,
    DISCORD_PASSPORT_CONFIG_MOBILE,
};
