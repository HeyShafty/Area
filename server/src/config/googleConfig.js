const GOOGLE_CLIENT_ID = '355270370316-80n2ips385e7p1pksh60ndl8boq071lk.apps.googleusercontent.com';
const GOOGLE_SECRET = 'G88SKVcRAurdB_NfbRs_KUNP';
const GOOGLE_CALLBACK = 'http://localhost:8080/connect/google/callback';
const MONGOOSE_GOOGLE_KEY = 'google';

const GOOGLE_PASSPORT_CONFIG = {
    clientID: GOOGLE_CLIENT_ID,
    clientSecret: GOOGLE_SECRET,
    callbackURL: GOOGLE_CALLBACK,
    passReqToCallback: true
};

module.exports = {
    GOOGLE_PASSPORT_CONFIG,
    GOOGLE_SECRET,
    GOOGLE_CALLBACK,
    GOOGLE_CLIENT_ID,
    MONGOOSE_GOOGLE_KEY
};
