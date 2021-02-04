const GOOGLE_CLIENT_ID_WEB = '355270370316-80n2ips385e7p1pksh60ndl8boq071lk.apps.googleusercontent.com';
const GOOGLE_CLIENT_ID_MOBILE = '355270370316-08j5i2no7n1115ilhuelcv60jnd8lptp.apps.googleusercontent.com';
const GOOGLE_SECRET = 'G88SKVcRAurdB_NfbRs_KUNP';
const MONGOOSE_GOOGLE_KEY = 'google';

const GOOGLE_REDIRECT_URI_WEB = 'http://localhost:8080/connect/google/callback';
const GOOGLE_REDIRECT_URI_WEB_ESCAPED = 'http%3A%2F%2Flocalhost%3A8080%2Fconnect%2Fgoogle%2Fcallback';
const GOOGLE_REDIRECT_URI_MOBILE = 'area.app:/auth';
const GOOGLE_REDIRECT_URI_MOBILE_ESCAPED = 'area.app%3A/auth'; // TODO: is it really escaped ?

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
    GOOGLE_REDIRECT_URI_WEB_ESCAPED,
    GOOGLE_REDIRECT_URI_MOBILE_ESCAPED,
    GOOGLE_PASSPORT_CONFIG_WEB,
    GOOGLE_PASSPORT_CONFIG_MOBILE,
};
