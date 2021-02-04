const GOOGLE_CLIENT_ID_WEB = '355270370316-80n2ips385e7p1pksh60ndl8boq071lk.apps.googleusercontent.com';
const GOOGLE_CLIENT_ID_MOBILE = '355270370316-08j5i2no7n1115ilhuelcv60jnd8lptp.apps.googleusercontent.com';
const GOOGLE_SECRET = 'G88SKVcRAurdB_NfbRs_KUNP';
const GOOGLE_REDIRECT_URI_WEB = 'http://localhost:8080/connect/google/callback';
const GOOGLE_REDIRECT_URI_MOBILE = 'area.app:/auth';
const MONGOOSE_GOOGLE_KEY = 'google';

const GOOGLE_SCOPES = [ 'email', 'profile', 'openid', 'https://www.googleapis.com/auth/youtube.readonly' ];

const GOOGLE_PASSPORT_CONFIG_WEB = {
    clientID: GOOGLE_CLIENT_ID_WEB,
    clientSecret: GOOGLE_SECRET,
    callbackURL: GOOGLE_REDIRECT_URI_WEB,
    passReqToCallback: true
};

const GOOGLE_PASSPORT_CONFIG_MOBILE = {
    clientID: GOOGLE_CLIENT_ID_MOBILE,
    clientSecret: GOOGLE_SECRET,
    callbackURL: GOOGLE_REDIRECT_URI_MOBILE,
    passReqToCallback: true
};

module.exports = {
    MONGOOSE_GOOGLE_KEY,
    GOOGLE_PASSPORT_CONFIG_WEB,
    GOOGLE_PASSPORT_CONFIG_MOBILE,
    GOOGLE_SCOPES
};
