import 'package:flutter/cupertino.dart';
import 'package:oauth2_client/oauth2_client.dart';

class AzureOAuth2Client extends OAuth2Client {
  AzureOAuth2Client({@required String redirectUri, @required customUriScheme})
      : super(
            authorizeUrl: 'https://login.microsoftonline.com/901cb4ca-b862-4029-9306-e5cd0f6d9f86/oauth2/v2.0/authorize',
            tokenUrl: 'https://login.microsoftonline.com/901cb4ca-b862-4029-9306-e5cd0f6d9f86/oauth2/v2.0/token',
            redirectUri: redirectUri,
            customUriScheme: customUriScheme,
            refreshUrl: 'https://login.microsoftonline.com/901cb4ca-b862-4029-9306-e5cd0f6d9f86/oauth2/v2.0/authorize');
}
