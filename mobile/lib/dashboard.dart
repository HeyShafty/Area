import 'dart:async';

import 'package:area/models/service_information.dart';
import 'package:area/services/area_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'area_services/base_page.dart';
import 'area_services/option.dart';
import 'constants.dart';

class MyDashboardPage extends StatefulWidget {
  @override
  _MyDashboardPageState createState() => _MyDashboardPageState();
}

class _MyDashboardPageState extends State<MyDashboardPage> {
  final AreaService areaServiceInstance = AreaService();
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  final StreamController<Map<String, String>> _actionParamsController = StreamController<Map<String, String>>();
  final StreamController<Map<String, String>> _reactionParamsController = StreamController<Map<String, String>>();

  ServiceInformation _selectedActionServiceInfo;
  ServiceInformation _selectedReactionServiceInfo;
  BasePage _actionService;
  BasePage _reactionService;
  Map<String, String> _actionParams = Map();
  Map<String, String> _reactionParams = Map();
  List<DropdownMenuItem<ServiceInformation>> _actionMenuItems;
  List<DropdownMenuItem<ServiceInformation>> _reactionMenuItems;
  Stream<Map<String, String>> stream;

  @override
  void initState() {
    super.initState();
    this._actionMenuItems = this.buildDropDownMenuItems(true);
    this._reactionMenuItems = this.buildDropDownMenuItems(false);
    this._actionParamsController.stream.listen((event) {
      this.setState(() {
        this._actionParams = event;
      });
    });
    this._reactionParamsController.stream.listen((event) {
      this.setState(() {
        this._reactionParams = event;
      });
    });
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
                padding: EdgeInsets.only(left: 45.0, right: 45.0, top: 20.0),
                child: Column(children: [
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32.0), color: Color(0xffe5e8e8)),
                      child: Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
                          child: Column(children: [
                            Text("ACTION", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                            Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32.0),
                                        color: Colors.white,
                                        border: Border.all(width: 2.0, color: Colors.grey)),
                                    padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                                    width: 200.0,
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton<ServiceInformation>(
                                            value: this._selectedActionServiceInfo,
                                            items: this._actionMenuItems,
                                            onChanged: (value) async {
                                              if (value.uri != null &&
                                                  await this.areaServiceInstance.isConnectedToService(value.name) == false) {
                                                this.setState(() {
                                                  this._selectedActionServiceInfo = null;
                                                  this._actionService = null;
                                                });
                                                return this.showToast("Please go to profile page and sign in with this service to use it.");
                                              }
                                              this._actionParams.clear();
                                              this.setState(() {
                                                this._selectedActionServiceInfo = value;
                                                this._actionService = value.createServiceInstance(this._actionParamsController, true);
                                              });
                                            })))),
                            if (this._actionService != null) this._actionService
                          ]))),
                  Padding(padding: EdgeInsets.only(top: 40.0)),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32.0), color: Color(0xffe5e8e8)),
                      child: Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
                          child: Column(children: [
                            Text("REACTION", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                            Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32.0),
                                        color: Colors.white,
                                        border: Border.all(width: 2.0, color: Colors.grey)),
                                    padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                                    width: 200.0,
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton<ServiceInformation>(
                                            value: this._selectedReactionServiceInfo,
                                            items: this._reactionMenuItems,
                                            onChanged: (value) async {
                                              if (value.uri != null &&
                                                  await this.areaServiceInstance.isConnectedToService(value.name) == false) {
                                                this.setState(() {
                                                  this._selectedReactionServiceInfo = null;
                                                  this._reactionService = null;
                                                });
                                                return this.showToast("Please go to profile page and sign in with this service to use it.");
                                              }
                                              this._reactionParams.clear();
                                              this.setState(() {
                                                this._selectedReactionServiceInfo = value;
                                                this._reactionService = value.createServiceInstance(this._reactionParamsController, false);
                                              });
                                            })))),
                            if (this._reactionService != null) this._reactionService
                          ]))),
                  Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: RoundedLoadingButton(
                          controller: this._btnController,
                          child: Text('Submit', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                          onPressed: this.isButtonActivated() ? this.onButtonPressed : null))
                ]))));
  }

  bool isButtonActivated() {
    if (this._actionService == null || this._reactionService == null) return false;

    Option chooseActionOption = this._actionService.getActionOption(this._actionParams[ACTION_KEY]);
    Option chooseReactionOption = this._reactionService.getReactionOption(this._reactionParams[REACTION_KEY]);
    if (chooseActionOption == null) {
      return false;
    }
    if (chooseReactionOption == null) {
      return false;
    }

    if (this._actionParams.length != chooseActionOption.inputs.length + 1 ||
        this._reactionParams.length != chooseReactionOption.inputs.length + 1) {
      return false;
    }
    return true;
  }

  onButtonPressed() {
    return this.showToast("Everything is alright!");
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
