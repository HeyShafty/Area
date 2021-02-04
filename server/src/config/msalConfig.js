const msal = require('@azure/msal-node');

const AZURE_CLIENT_ID = 'a8dcacc9-80da-4a2b-9f8a-6e20221951d0';
const AZURE_AUTHORITY = 'https://login.microsoftonline.com/common/';
const AZURE_ISSUER = 'https://login.microsoftonline.com/901cb4ca-b862-4029-9306-e5cd0f6d9f86/v2.0';
const AZURE_CLIENT_SECRET = '~p94lnyu4O_5GD5ABNAFh-~vgh1OIyWoU.';

const MSAL_SCOPES = [ 'profile', 'openid', 'offline_access', 'email', 'User.Read', 'Mail.Read', 'Mail.Send' ];
const MSAL_REDIRECT_URI_WEB = 'http://localhost:8080/connect/microsoft/callback';
const MSAL_REDIRECT_URI_MOBILE = 'msauth.area.app://auth';
const MONGOOSE_MSAL_KEY = 'microsoft';

const MSAL_CONFIG = {
    auth: {
        clientId: AZURE_CLIENT_ID,
        authority: AZURE_AUTHORITY,
        clientSecret: AZURE_CLIENT_SECRET
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
    MSAL_CONFIG,
    MSAL_SCOPES,
    MSAL_REDIRECT_URI_WEB,
    MSAL_REDIRECT_URI_MOBILE,
    MONGOOSE_MSAL_KEY
};
