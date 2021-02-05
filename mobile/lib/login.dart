import 'dart:async';
import 'dart:io';

import 'package:area/exceptions/BadResponseException.dart';
import 'package:area/exceptions/WrongEmailPasswordCombination.dart';
import 'package:area/register.dart';
import 'package:area/services/area_service.dart';
import 'package:area/services/shared_preferences_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:msal_flutter/msal_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'constants.dart';
import 'main_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AreaService areaServiceInstance = AreaService();
  String _emailError;
  String _passwordError;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    Timer.run(() => this.showServerIpAlertDialog(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text("Sign in"),
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 200.0,
                      child: Image.asset(
                        'assets/images/AREALOGO.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextField(
                          obscureText: false,
                          controller: this._emailController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              errorText: this._emailError,
                              hintText: "Email",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                          keyboardType: TextInputType.emailAddress,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextField(
                        obscureText: true,
                        controller: this._passwordController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            errorText: this._passwordError,
                            hintText: "Password",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: RoundedLoadingButton(
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        controller: _btnController,
                        onPressed: this._isLoading
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                this.signInWithCredentials(this._emailController.value.text, this._passwordController.value.text);
                              },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextButton(
                          onPressed: this._isLoading ? null : () => this.openRegisterPage(),
                          child: Text(
                            'Don\'t have an account? Sign up',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                        child: Text(
                          'Or sign in with:',
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        )),
                    IconButton(
                      onPressed: this._isLoading
                          ? null
                          : () async {
                              await this.signInWithMicrosoft();
                            },
                      icon: Image.asset("assets/images/microsoft.png"),
                      color: Colors.blue,
                    )
                  ]))),
        ));
  }

  void openRegisterPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
  }

  void openHomePage() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyMainPage()), (Route<dynamic> route) => false);
  }

  Future<void> signInWithMicrosoft() async {
    var pca =
        await PublicClientApplication.createPublicClientApplication(APP_ID, authority: "https://login.microsoftonline.com/" + TENANT_ID);

    this.setState(() {
      this._isLoading = true;
    });
    try {
      String token = await pca.acquireToken([SERVER_SCOPE]);
      await this.areaServiceInstance.signInWithAccessToken(token);
      return this.openHomePage();
    } on MsalException {
      this.showToast("Couldn't sign you in with Microsoft.");
    } on BadResponseException {
      this.showToast("Couldn't sign you in with Microsoft.");
    } catch (e) {
      this.showToast(e.toString());
    }
    this.setState(() {
      this._isLoading = false;
    });
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

  bool isFormValid(String email, String password) {
    bool isValid = true;
    String emailErrorMessage;
    String passwordErrorMessage;

    if (email.length == 0) {
      emailErrorMessage = "Email must not be empty";
      isValid = false;
    }
    if (RegExp(EMAIL_REGEX).hasMatch(email) == false) {
      emailErrorMessage = "Invalid email";
      isValid = false;
    }
    if (password.length < 3) {
      passwordErrorMessage = "Password must be formed of at least 3 characters";
      isValid = false;
    }
    this.setState(() {
      this._emailError = emailErrorMessage;
      this._passwordError = passwordErrorMessage;
    });
    return isValid;
  }

  Future<void> signInWithCredentials(String email, String password) async {
    this.setState(() {
      this._isLoading = true;
    });
    if (this.isFormValid(email, password) == false) {
      this._btnController.reset();
      this.setState(() {
        this._isLoading = false;
      });
      return;
    }
    try {
      this._btnController.start();
      await this.areaServiceInstance.signInWithCredentials(email, password);
      this._btnController.success();
      return this.openHomePage();
    } on WrongEmailPasswordCombination {
      this.showToast("Bad email / password combination.");
    } on BadResponseException {
      this.showToast("Couldn't sign you in.");
    } catch (e) {
      this.showToast(e.toString());
    }
    this._btnController.reset();
    this.setState(() {
      this._isLoading = false;
    });
  }

  Future<void> showServerIpAlertDialog(BuildContext context) async {
    String storedIp = await SharedPreferencesService.getString(IP_KEY);
    TextEditingController serverIpController;

    if (storedIp == null || storedIp == "") {
      serverIpController = TextEditingController(text: '10.0.2.2:8080');
    } else {
      serverIpController = TextEditingController(text: storedIp);
    }
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Server ip'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please enter the server ip address and port bellow.'),
                TextField(
                  obscureText: false,
                  controller: serverIpController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "10.0.2.2:8080",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(onPressed: () => exit(0), child: Text('Cancel')),
            TextButton(
                onPressed: () async {
                  if (serverIpController.value.text == "") {
                    return;
                  }

                  this.areaServiceInstance.serverIp = serverIpController.value.text;
                  FocusScope.of(context).unfocus();
                  try {
                    await this.areaServiceInstance.checkIp();
                  } on BadResponseException {
                    return this.showToast("Bad ip address.");
                  } catch (e) {
                    return this.showToast("Couldn't check server availability.");
                  }
                  await SharedPreferencesService.saveString(IP_KEY, serverIpController.value.text);
                  Navigator.of(context).pop();
                  if (await this.areaServiceInstance.getStoredAccessToken() == true) {
                    this.openHomePage();
                  }
                },
                child: Text('OK')),
          ],
        );
      },
    );
  }
}
