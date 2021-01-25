import { Configuration, LogLevel } from '@azure/msal-browser';

export const appId: string = '24ffcb55-7348-48a4-bbe7-c6c5b3763578';
export const redirectUri: string = 'http://localhost:8081/signin';
export const apiScope: string = 'api://db074310-a1fb-45a3-8dd9-8462d3f688f8/user.base.read';

export const tenantJWKSURI: string = 'https://login.microsoftonline.com/901cb4ca-b862-4029-9306-e5cd0f6d9f86/discovery/v2.0/keys';
export const IssuerURL: string = 'https://login.microsoftonline.com/901cb4ca-b862-4029-9306-e5cd0f6d9f86/v2.0';

export const connectionScopes: string[] = [
    apiScope,
];

export const msalConfig: Configuration = {
    auth: {
        clientId: appId,
        redirectUri: redirectUri,
        authority: 'https://login.microsoftonline.com/901cb4ca-b862-4029-9306-e5cd0f6d9f86'
    },
    cache: {
        cacheLocation: 'localStorage',
        storeAuthStateInCookie: true
    },
    system: {
        loggerOptions: {
            loggerCallback: (level: LogLevel, message: string, containsPii: boolean): void => {
                if (containsPii) {
                    return;
                }
                switch (level) {
                    case LogLevel.Error:
                        console.log(message);
                        return;
                    case LogLevel.Info:
                        console.log(message);
                        return;
                    case LogLevel.Verbose:
                        console.log(message);
                        return;
                    case LogLevel.Warning:
                        console.log(message);
                        return;
                }
            }
        }
    }
};