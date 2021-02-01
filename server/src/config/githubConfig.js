const GITHUB_CLIENT_ID = '36fd678ea9f580199c89';
const GITHUB_CLIENT_SECRET = 'f645ddd31a7d99c200e10290d5eb51b9966fcf6d';
const GITHUB_CALLBACK = 'http://localhost:8080/connect/github/callback';
const MONGOOSE_GITHUB_KEY = 'github';

const GITHUB_PASSPORT_CONFIG = {
    clientID: GITHUB_CLIENT_ID,
    clientSecret: GITHUB_CLIENT_SECRET,
    callbackURL: GITHUB_CALLBACK,
    passReqToCallback: true
};

module.exports = {
    GITHUB_PASSPORT_CONFIG,
    GITHUB_CLIENT_ID,
    GITHUB_CLIENT_SECRET,
    GITHUB_CALLBACK,
    MONGOOSE_GITHUB_KEY
}