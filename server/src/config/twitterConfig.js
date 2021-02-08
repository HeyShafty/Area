const TWITTER_CONSUMER_KEY = 'Se8fTwfmYF3LTZdSk4Xl2u5lg';
const TWITTER_CONSUMER_SECRET = '9rX5TQlSKfsQRC85pOY2Qaqb5V1zLBon3qDWJgyBJsuAzFya5Z';
const MONGOOSE_TWITTER_KEY = 'twitter';

const TWITTER_PASSPORT_CONFIG_WEB = {
    consumerKey: TWITTER_CONSUMER_KEY,
    consumerSecret: TWITTER_CONSUMER_SECRET,
    callbackURL: 'http://localhost:8080/connect/twitter/callback',
    passReqToCallback: true
};

module.exports = {
    TWITTER_PASSPORT_CONFIG_WEB,
    TWITTER_CONSUMER_KEY,
    TWITTER_CONSUMER_SECRET,
    MONGOOSE_TWITTER_KEY
};