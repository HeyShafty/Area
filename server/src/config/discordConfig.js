const DISCORD_CLIENT_ID = '805846126397095956';
const DISCORD_CLIENT_SECRET = '6g42_M2zOrT1ZuFNv-VaEnz87ahuQfyf';
const DISCORD_SCOPES = [ 'guilds', 'messages.read', 'identify', 'email' ];
const MONGOOSE_DISCORD_KEY = 'discord';
const BOT_TOKEN = 'ODEzMzU1Nzc1ODI1MTQ5OTYy.YDOGmA.Ee-nvgFu2v0FHo_7c6XBDd0WsgI';

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
    BOT_TOKEN
};
