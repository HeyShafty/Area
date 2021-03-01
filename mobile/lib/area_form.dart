import 'dart:async';
import 'dart:developer';

import 'package:area/models/service_information.dart';
import 'package:area/services/area_service.dart';
import 'package:area/services/toast_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'area_services/area_service_base.dart';
import 'area_services/option.dart';
import 'constants.dart';
import 'exceptions/bad_token_exception.dart';
import 'models/area.dart';

class AreaFormPage extends StatefulWidget {
  final AreaService _areaServiceInstance;

  AreaFormPage([AreaService areaService]) : _areaServiceInstance = areaService ?? AreaService();

  @override
  AreaFormPageState createState() => AreaFormPageState(_areaServiceInstance);
}

class AreaFormPageState<Page extends AreaFormPage> extends State<Page> {
  @protected
  final AreaService areaServiceInstance;
  @protected
  final StreamController<Map<String, dynamic>> actionParamsController = StreamController<Map<String, dynamic>>();
  @protected
  final StreamController<Map<String, dynamic>> reactionParamsController = StreamController<Map<String, dynamic>>();
  @protected
  final RoundedLoadingButtonController buttonController = new RoundedLoadingButtonController();

  @protected
  ServiceInformation selectedActionServiceInfo;
  @protected
  ServiceInformation selectedReactionServiceInfo;
  @protected
  AreaServiceBase actionService;
  @protected
  AreaServiceBase reactionService;
  @protected
  Map<String, dynamic> actionParams = Map();
  @protected
  Map<String, dynamic> reactionParams = Map();

  List<DropdownMenuItem<ServiceInformation>> _actionMenuItems = [];
  List<DropdownMenuItem<ServiceInformation>> _reactionMenuItems = [];

  AreaFormPageState(AreaService areaService) : this.areaServiceInstance = areaService;

  @override
  void initState() {
    super.initState();
    this._actionMenuItems = this.buildDropDownMenuItems(true);
    this._reactionMenuItems = this.buildDropDownMenuItems(false);
    this.actionParamsController.stream.listen((event) {
      this.setState(() {
        this.actionParams = event;
      });
    });
    this.reactionParamsController.stream.listen((event) {
      this.setState(() {
        this.reactionParams = event;
      });
    });
  }

  @override
  void dispose() {
    actionParamsController.close();
    reactionParamsController.close();
    super.dispose();
  }

  List<DropdownMenuItem<ServiceInformation>> buildDropDownMenuItems(bool actions) {
    List<DropdownMenuItem<ServiceInformation>> items = [];

    for (MapEntry<String, ServiceInformation> serviceMapEntry in SERVICES_INFORMATION_MAP.entries) {
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: this.getFormTitle(),
        ),
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
                child: Center(
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.only(left: 45.0, right: 45.0, top: 20.0, bottom: 20.0),
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
                                                        key: Key("action_dropdown"),
                                                        isExpanded: true,
                                                        value: this.selectedActionServiceInfo,
                                                        items: this._actionMenuItems,
                                                        onChanged: (value) async {
                                                          if (value.uri != null &&
                                                              await this.areaServiceInstance.isConnectedToService(value.name) == false) {
                                                            this.setState(() {
                                                              this.selectedActionServiceInfo = null;
                                                              this.actionService = null;
                                                            });
                                                            return ToastService.showToast(
                                                                "Please go to profile page and sign in with this service to use it.");
                                                          }
                                                          this.actionParams.clear();
                                                          this.setState(() {
                                                            this.selectedActionServiceInfo = value;
                                                            this.actionService =
                                                                value.createServiceInstance(this.actionParamsController, true);
                                                          });
                                                        })))),
                                        if (this.actionService != null) this.actionService
                                      ]))),
                              Padding(padding: EdgeInsets.only(top: 40.0)),
                              Container(
                                  key: Key("reaction"),
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
                                                        key: Key("reaction_dropdown"),
                                                        isExpanded: true,
                                                        value: this.selectedReactionServiceInfo,
                                                        items: this._reactionMenuItems,
                                                        onChanged: (value) async {
                                                          if (value.uri != null &&
                                                              await this.areaServiceInstance.isConnectedToService(value.name) == false) {
                                                            this.setState(() {
                                                              this.selectedReactionServiceInfo = null;
                                                              this.reactionService = null;
                                                            });
                                                            return ToastService.showToast(
                                                                "Please go to profile page and sign in with this service to use it.");
                                                          }
                                                          this.reactionParams.clear();
                                                          this.setState(() {
                                                            this.selectedReactionServiceInfo = value;
                                                            this.reactionService =
                                                                value.createServiceInstance(this.reactionParamsController, false);
                                                          });
                                                        })))),
                                        if (this.reactionService != null) this.reactionService
                                      ]))),
                              Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: RoundedLoadingButton(
                                      controller: this.buttonController,
                                      child: Text('Submit', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                                      onPressed: this.isButtonActivated() ? this.onButtonPressed : null))
                            ])))))));
  }

  Widget getFormTitle() {
    return Text('Add Area');
  }

  bool isButtonActivated() {
    if (this.actionService == null || this.reactionService == null) {
      return false;
    }

    Option chooseActionOption = this.actionService.getActionOption(this.actionParams[ACTION_KEY]);
    Option chooseReactionOption = this.reactionService.getReactionOption(this.reactionParams[REACTION_KEY]);
    if (chooseActionOption == null) {
      return false;
    }
    if (chooseReactionOption == null) {
      return false;
    }

    if (this.actionParams.length != chooseActionOption.inputs.length + 1 ||
        this.reactionParams.length != chooseReactionOption.inputs.length + 1) {
      return false;
    }
    return true;
  }

  onButtonPressed() async {
    Area area = Area("", AreaAction(this.selectedActionServiceInfo.name.toLowerCase(), this.actionParams[ACTION_KEY], this.actionParams),
        AreaReaction(this.selectedReactionServiceInfo.name.toLowerCase(), this.reactionParams[REACTION_KEY], this.reactionParams));

    try {
      await this.areaServiceInstance.addArea(area);
      ToastService.showToast("Area added successfully!", Colors.green);
      return Navigator.pop(context);
    } on BadTokenException {
      ToastService.showToast("Invalid token, please sign out.");
    } on Exception catch (e) {
      log(e.toString());
      ToastService.showToast("Couldn't add a new area.");
    } catch (e) {
      log(e);
      ToastService.showToast("Couldn't add a new area.");
    }
    this.buttonController.reset();
  }
}
