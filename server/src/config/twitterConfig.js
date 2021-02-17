const TWITTER_CONSUMER_KEY = 'dLnwPSwWtoAUbfEcvckljBytU';
const TWITTER_CONSUMER_SECRET = 'nrjTVAFpFjlRgakLMfjbEklcwPZmM6R4uq1Bpv4NJVWmiLEY1B';
const MONGOOSE_TWITTER_KEY = 'twitter';

const TWITTER_PASSPORT_CONFIG_WEB = {
    consumerKey: TWITTER_CONSUMER_KEY,
    consumerSecret: TWITTER_CONSUMER_SECRET,
    callbackURL: 'http://localhost:8080/connect/twitter/callback',
    passReqToCallback: true
};

const TWITTER_PASSPORT_CONFIG_MOBILE = {
    consumerKey: TWITTER_CONSUMER_KEY,
    consumerSecret: TWITTER_CONSUMER_SECRET,
    callbackURL: 'area.app://',
    passReqToCallback: true
}

module.exports = {
    TWITTER_PASSPORT_CONFIG_WEB,
    TWITTER_PASSPORT_CONFIG_MOBILE,
    TWITTER_CONSUMER_KEY,
    TWITTER_CONSUMER_SECRET,
    MONGOOSE_TWITTER_KEY
};