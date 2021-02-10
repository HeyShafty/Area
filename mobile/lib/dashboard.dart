import 'dart:developer';

import 'package:area/models/service_information.dart';
import 'package:area/services/area_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'area_services/base_page.dart';
import 'constants.dart';

class MyDashboardPage extends StatefulWidget {
  @override
  _MyDashboardPageState createState() => _MyDashboardPageState();
}

class _MyDashboardPageState extends State<MyDashboardPage> {
  final AreaService areaServiceInstance = AreaService();
  ServiceInformation _selectedActionServiceInfo;
  ServiceInformation _selectedReactionServiceInfo;
  BasePage _actionService;
  BasePage _reactionService;
  Map<String, String> _actionParams = Map();
  Map<String, String> _reactionParams = Map();
  List<DropdownMenuItem<ServiceInformation>> _actionMenuItems;
  List<DropdownMenuItem<ServiceInformation>> _reactionMenuItems;

  @override
  void initState() {
    super.initState();
    this._actionMenuItems = this.buildDropDownMenuItems(true);
    this._reactionMenuItems = this.buildDropDownMenuItems(false);
  }

  List<DropdownMenuItem<ServiceInformation>> buildDropDownMenuItems(bool actions) {
    List<DropdownMenuItem<ServiceInformation>> items = List();
    for (MapEntry<ServiceType, ServiceInformation> serviceMapEntry in SERVICES_INFORMATION_MAP.entries) {
      if (actions && serviceMapEntry.value.hasActions) {
        items.add(DropdownMenuItem(
          child: Text(serviceMapEntry.value.name),
          value: serviceMapEntry.value,
        ));
      } else if (!actions && serviceMapEntry.value.hasReactions) {
        items.add(DropdownMenuItem(
          child: Text(serviceMapEntry.value.name),
          value: serviceMapEntry.value,
        ));
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        children: [
          Text("ACTION", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          DropdownButton<ServiceInformation>(
              value: this._selectedActionServiceInfo,
              items: this._actionMenuItems,
              onChanged: (value) async {
                if (value.uri != null && await this.areaServiceInstance.isConnectedToService(value.name) == false) {
                  this.setState(() {
                    this._selectedActionServiceInfo = null;
                    this._actionService = null;
                  });
                  return this.showToast("Please go to profile page and sign in with this service to use it.");
                }
                this._actionParams.clear();
                this.setState(() {
                  this._selectedActionServiceInfo = value;
                  this._actionService = value.createServiceInstance(_actionParams, true);
                });
              }),
          if (this._actionService != null) this._actionService,
          Text("REACTION", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          DropdownButton<ServiceInformation>(
              value: this._selectedReactionServiceInfo,
              items: this._reactionMenuItems,
              onChanged: (value) async {
                if (value.uri != null && await this.areaServiceInstance.isConnectedToService(value.name) == false) {
                  this.setState(() {
                    this._selectedReactionServiceInfo = null;
                    this._reactionService = null;
                  });
                  return this.showToast("Please go to profile page and sign in with this service to use it.");
                }
                this._reactionParams.clear();
                this.setState(() {
                  this._selectedReactionServiceInfo = value;
                  this._reactionService = value.createServiceInstance(_reactionParams, false);
                });
              }),
          if (this._reactionService != null) this._reactionService,
          Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RoundedLoadingButton(
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    log(this._actionParams.toString());
                    log(this._reactionParams.toString());
                  }))
        ],
      ),
    )));
  }

  showSingleSelectDialog(List<String> items) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose an action"),
          );
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
}
