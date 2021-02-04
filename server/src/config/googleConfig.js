const GOOGLE_SECRET = 'G88SKVcRAurdB_NfbRs_KUNP';
const GOOGLE_SCOPES = [ 'email', 'profile', 'openid', 'https://www.googleapis.com/auth/youtube.readonly' ];
const MONGOOSE_GOOGLE_KEY = 'google';

const GOOGLE_PASSPORT_CONFIG_WEB = {
    clientID: '355270370316-80n2ips385e7p1pksh60ndl8boq071lk.apps.googleusercontent.com',
    clientSecret: GOOGLE_SECRET,
    callbackURL: 'http://localhost:8080/connect/google/callback',
    passReqToCallback: true
};

const GOOGLE_PASSPORT_CONFIG_MOBILE = {
    clientID: '355270370316-08j5i2no7n1115ilhuelcv60jnd8lptp.apps.googleusercontent.com',
    clientSecret: GOOGLE_SECRET,
    callbackURL: 'area.app:/auth',
    passReqToCallback: true
};

module.exports = {
    MONGOOSE_GOOGLE_KEY,
    GOOGLE_SCOPES,
    GOOGLE_PASSPORT_CONFIG_WEB,
    GOOGLE_PASSPORT_CONFIG_MOBILE,
};
