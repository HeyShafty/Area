import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'main.dart';
import 'services/area_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AreaService areaServiceInstance = AreaService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _usernameError;
  String _emailError;
  String _passwordError;
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.blue, title: Text("Sign up"), centerTitle: true),
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
                        padding: const EdgeInsets.only(top: 25.0),
                        child: TextField(
                          autofocus: true,
                          obscureText: false,
                          controller: _usernameController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              errorText: this._usernameError,
                              hintText: "Username",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: TextField(
                          obscureText: false,
                          controller: _emailController,
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
                        controller: _passwordController,
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
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        controller: _btnController,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          this.signUp(this._usernameController.value.text, this._emailController.value.text,
                              this._passwordController.value.text);
                        },
                      ),
                    )
                  ]))),
        ));
  }

  void openHomePage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  title: "mdr",
                )),
        (Route<dynamic> route) => false);
  }

  bool isFormValid(String username, String email, String password) {
    bool isValid = true;
    String usernameError;
    String emailError;
    String passwordError;

    if (email.length == 0) {
      emailError = "Email must not be empty";
      isValid = false;
    }
    if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(email) ==
        false) {
      emailError = "Invalid email";
      isValid = false;
    }
    if (password.length < 6) {
      passwordError = "Password must be formed of at least 6 characters";
      isValid = false;
    }
    if (username.length < 3) {
      usernameError = "Username must be formed of at least 3 characters";
      isValid = false;
    }
    this.setState(() {
      this._usernameError = usernameError;
      this._emailError = emailError;
      this._passwordError = passwordError;
    });
    return isValid;
  }

  Future<void> signUp(String username, String email, String password) async {
    if (this.isFormValid(username, email, password) == false) {
      this._btnController.reset();
      return;
    }
    try {
      this._btnController.start();
      await this.areaServiceInstance.signUp(username, email, password);
      this.openHomePage();
      this._btnController.success();
    } catch (e) {
      this._btnController.reset();
      this.showToast(e.toString());
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
}
