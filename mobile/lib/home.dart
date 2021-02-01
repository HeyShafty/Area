import 'dart:developer';

import 'package:area/custom_oauth2_clients/azure_oauth2_client.dart';
import 'package:area/services/area_service.dart';
import 'package:area/services/shared_preferences_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import 'constants.dart';
import 'login.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AreaService areaServiceInstance = AreaService();
  Uri uri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: IconButton(onPressed: () => this.signOut(), icon: Icon(Icons.logout)),
          )
        ],
        title: Text('Area'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Theme.of(context).primaryColor,
                child: MaterialButton(
                    minWidth: (MediaQuery.of(context).size.width),
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      await this.signInWithGitHub();
                    },
                    child: Text(
                      'Sign in with GitHub',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ))),
            Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Theme.of(context).primaryColor,
                child: MaterialButton(
                    minWidth: (MediaQuery.of(context).size.width),
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      await this.signInWithGoogle();
                    },
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ))),
            Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Theme.of(context).primaryColor,
                child: MaterialButton(
                    minWidth: (MediaQuery.of(context).size.width),
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      await this.signInWithMicrosoft();
                    },
                    child: Text(
                      'Sign in with Microsoft',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ))),
          ],
        ),
      ),
    );
  }

  signInWithService(Service service) async {
    try {
      final String url = await this.areaServiceInstance.getServiceRedirectionUrl(service);
      await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: 'area.chad');
    } catch (e) {
      log(e.toString());
      this.showToast("Couldn't sign you in with this service.");
    }
  }

  signInWithGitHub() async {
    try {
      OAuth2Client ghClient = GitHubOAuth2Client(redirectUri: 'area.app://oauth2redirect', customUriScheme: 'area.app');
      OAuth2Helper oauth2Helper = OAuth2Helper(ghClient,
          grantType: OAuth2Helper.AUTHORIZATION_CODE,
          clientId: '0aae79080a63215c218d',
          clientSecret: 'ea9b62a444d111752dc0272a4091d403f64adae5',
          scopes: []);
      AccessTokenResponse oui = await oauth2Helper.getToken();
      log(oui.accessToken);
    } catch (e) {
      this.showToast("Something went wrong.");
    }
  }

  signInWithGoogle() async {
    try {
      OAuth2Client googleClient = GoogleOAuth2Client(redirectUri: 'area.app:/oauth2redirect', customUriScheme: 'area.app');
      OAuth2Helper oauth2Helper = OAuth2Helper(googleClient,
          grantType: OAuth2Helper.AUTHORIZATION_CODE,
          clientId: '708618453020-6s0ic8uavrhfgg5vmdsge8si0hjg7e7a.apps.googleusercontent.com',
          scopes: ['https://www.googleapis.com/auth/userinfo.email']);
      AccessTokenResponse oui = await oauth2Helper.getToken();
      log(oui.accessToken);
      log(oui.refreshToken);
    } catch (e) {
      this.showToast("Something went wrong.");
    }
  }

  signInWithMicrosoft() async {
    try {
      OAuth2Client googleClient = AzureOAuth2Client(redirectUri: 'area.app://auth', customUriScheme: 'area.app');
      OAuth2Helper oauth2Helper = OAuth2Helper(googleClient,
          grantType: OAuth2Helper.AUTHORIZATION_CODE,
          clientId: '24ffcb55-7348-48a4-bbe7-c6c5b3763578',
          scopes: [
            'https://graph.microsoft.com/profile',
            'https://graph.microsoft.com/openid',
            'https://graph.microsoft.com/offline_access'
          ]);
      AccessTokenResponse oui = await oauth2Helper.fetchToken();
      log(oui.accessToken);
      log(oui.refreshToken);
    } catch (e) {
      log(e.toString());
      this.showToast("Something went wrong.");
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  signOut() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to sign out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
            TextButton(
                onPressed: () async {
                  await SharedPreferencesService.clearValueByKey(TOKEN_KEY);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (Route<dynamic> route) => false);
                },
                child: Text('Yes')),
          ],
        );
      },
    );
  }
}
