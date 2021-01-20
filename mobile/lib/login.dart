import 'package:area/register.dart';
import 'package:area/services/area_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:msal_flutter/msal_flutter.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Sign in"),
          centerTitle: true,
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
                          controller: usernameController,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).primaryColor,
                        child: MaterialButton(
                            minWidth: (MediaQuery.of(context).size.width),
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {},
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextButton(
                          onPressed: () => this.openRegisterPage(context),
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
                      onPressed: () async {
                        await this.officeOauth();
                      },
                      icon: Image.asset("assets/images/microsoft.png"),
                      color: Colors.blue,
                    )
                  ]))),
        ));
  }

  void openRegisterPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  Future<void> officeOauth() async {
    var pca = await PublicClientApplication.createPublicClientApplication(
        "24ffcb55-7348-48a4-bbe7-c6c5b3763578",
        authority:
            "https://login.microsoftonline.com/901cb4ca-b862-4029-9306-e5cd0f6d9f86");

    try {
      String token = await pca.acquireToken(
          ["api://db074310-a1fb-45a3-8dd9-8462d3f688f8/user.base.read"]);
      AreaService().accessToken = token;
    } on MsalException {
      Fluttertoast.showToast(
          msg: "Something went wrong...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
