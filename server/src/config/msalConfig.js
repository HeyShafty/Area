const msal = require('@azure/msal-node');

const MSAL_SCOPES = [ 'profile', 'openid', 'offline_access', 'email', 'User.Read', 'Mail.Read', 'Mail.Send' ];
const MSAL_REDIRECT_URI_WEB = 'http://localhost:8080/connect/microsoft/callback';
const MSAL_REDIRECT_URI_MOBILE = 'msauth.area.app://auth';
const MONGOOSE_MSAL_KEY = 'microsoft';

const MSAL_CONFIG = {
    auth: {
        clientId: 'a8dcacc9-80da-4a2b-9f8a-6e20221951d0',
        authority: 'https://login.microsoftonline.com/common/',
        clientSecret: '~p94lnyu4O_5GD5ABNAFh-~vgh1OIyWoU.'
    },
    system: {
        loggerOptions: {
            loggerCallback(loglevel, message) {
                console.log(message);
            },
            piiLoggingEnabled: false,
            logLevel: msal.LogLevel.Verbose
        }
    }
};

module.exports = {
    MONGOOSE_MSAL_KEY,
    MSAL_SCOPES,
    MSAL_REDIRECT_URI_WEB,
    MSAL_REDIRECT_URI_MOBILE,
    MSAL_CONFIG,
};
