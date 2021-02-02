import 'dart:developer';

import 'package:area/Models/service.dart';
import 'package:area/services/area_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Models/user.dart';
import 'constants.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final AreaService areaServiceInstance = AreaService();
  User _user = User("micheluser", "michel.jean@epitech.eu", false, true, false, true);
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // TODO: get les infos du profile
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Column(
                children: [
                  Icon(
                    Icons.person,
                    size: 100.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      _user.username,
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    _user.email,
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: getSignInWith(SERVICES_CONNECT_URI[ServiceType.GITHUB], false),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: getSignInWith(SERVICES_CONNECT_URI[ServiceType.GOOGLE], false),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: getSignInWith(SERVICES_CONNECT_URI[ServiceType.MICROSOFT], false),
                  ),
                  getSignInWith(SERVICES_CONNECT_URI[ServiceType.TWITTER], false),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  signInWithService(Service service) async {
    try {
      final String url = await this.areaServiceInstance.getServiceRedirectionUrl(service);
      log(url);
      //final String callbackUrl = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: 'area.app');
      //log(callbackUrl);
    } catch (e) {
      log(e.toString());
      this.showToast("Couldn't sign you in with this service.");
    }
  }

  getSignInWith(Service service, bool isAuthenticated) {
    if (isAuthenticated) {
      return FlatButton(
          onPressed: null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.blue)),
          height: 50.0,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(service.iconPath),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'You\'re connected with ' + service.name,
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ));
    }
    return FlatButton(
        onPressed: () async {
          await this.signInWithService(service);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.transparent)),
        height: 50.0,
        color: Color(0xFFd5d8dc),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(service.iconPath),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                'Connect with ' + service.name,
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ));
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
