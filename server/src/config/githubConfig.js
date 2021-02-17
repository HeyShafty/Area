const GITHUB_SCOPES = [ 'repo', 'user', 'admin:repo_hook' ];
const MONGOOSE_GITHUB_KEY = 'github';

const GITHUB_PASSPORT_CONFIG_WEB = {
    clientID: '36fd678ea9f580199c89',
    clientSecret: 'f645ddd31a7d99c200e10290d5eb51b9966fcf6d',
    callbackURL: 'http://localhost:8080/connect/github/callback',
    passReqToCallback: true
};

const GITHUB_PASSPORT_CONFIG_MOBILE = {
    clientID: '88b13af95a182d1cc87c',
    clientSecret: 'da8eae824222bbef921a4a75c027c6f0c6b60884',
    callbackURL: 'area.app://auth',
    passReqToCallback: true
};

module.exports = {
    MONGOOSE_GITHUB_KEY,
    GITHUB_SCOPES,
    GITHUB_PASSPORT_CONFIG_WEB,
    GITHUB_PASSPORT_CONFIG_MOBILE,
}
