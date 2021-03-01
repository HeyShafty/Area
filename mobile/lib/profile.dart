import 'dart:developer';

import 'package:area/exceptions/bad_token_exception.dart';
import 'package:area/models/service_information.dart';
import 'package:area/models/user.dart';
import 'package:area/services/area_service.dart';
import 'package:area/services/toast_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import 'constants.dart';

class MyProfilePage extends StatefulWidget {
  final AreaService _areaServiceInstance;

  MyProfilePage([AreaService areaService]) : _areaServiceInstance = areaService ?? AreaService();

  @override
  _MyProfilePageState createState() => _MyProfilePageState(_areaServiceInstance);
}

class _MyProfilePageState extends State<MyProfilePage> {
  final AreaService _areaServiceInstance;

  User _user;
  bool _isLoading = false;

  _MyProfilePageState(AreaService areaService) : this._areaServiceInstance = areaService;

  @override
  void initState() {
    this.getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Column(
                children: this._user == null
                    ? <Widget>[CircularProgressIndicator()]
                    : <Widget>[
                        Icon(
                          Icons.person,
                          size: 100.0,
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 60.0),
                            child: Column(children: [
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(_user.displayName,
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))),
                              Text(_user.email, style: TextStyle(color: Colors.black, fontSize: 15))
                            ])),
                        Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Column(
                                children: SERVICES_INFORMATION_MAP.entries.map((e) {
                              if (e.value.uri != null) {
                                return Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child:
                                        getSignInWith(e.value, this._user.servicesConnectInformation.contains(e.value.name.toLowerCase())));
                              }
                              return Container();
                            }).toList()))
                      ])));
  }

  signInWithService(ServiceInformation service) async {
    setState(() {
      this._isLoading = true;
    });
    try {
      final String url = await this._areaServiceInstance.getServiceRedirectionUrl(service);
      final String callbackUrl = await FlutterWebAuth.authenticate(url: url.toString(), callbackUrlScheme: service.callbackUrlScheme);

      await this._areaServiceInstance.handleServiceRedirection(callbackUrl, service);
      await this.getUserProfile();
    } on BadTokenException {
      ToastService.showToast("Invalid token, please sign out.");
    } catch (e) {
      log(e.toString());
      ToastService.showToast("Couldn't sign you in with this service.");
    }
    setState(() {
      this._isLoading = false;
    });
  }

  getSignInWith(ServiceInformation service, bool isAuthenticated) {
    if (isAuthenticated) {
      return MaterialButton(
          onPressed: null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.blue)),
          height: 50.0,
          color: Colors.white,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(service.iconPath),
            Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'You\'re connected with ' + service.name,
                  style: TextStyle(color: Colors.black),
                ))
          ]));
    }
    return MaterialButton(
        onPressed: () async {
          if (this._isLoading) {
            return;
          }
          await this.signInWithService(service);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.transparent)),
        height: 50.0,
        color: Color(0xFFd5d8dc),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: this._isLoading
                ? [CircularProgressIndicator()]
                : [
                    Image.asset(service.iconPath),
                    Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('Connect with ' + service.name, style: TextStyle(color: Colors.black)))
                  ]));
  }

  Future<void> getUserProfile() async {
    try {
      final User user = await this._areaServiceInstance.getUserProfile();

      setState(() {
        this._user = user;
      });
    } on BadTokenException {
      ToastService.showToast("Invalid token, please sign out.");
    } on Exception {
      ToastService.showToast("Cannot get user profile information.");
    } catch (e) {
      log(e);
      ToastService.showToast("Cannot get user profile information.");
    }
  }
}
