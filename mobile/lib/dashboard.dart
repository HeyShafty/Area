import 'package:area/area_services/i_service.dart';
import 'package:area/models/service_information.dart';
import 'package:area/services/area_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class ListItem {
  final String name;
  final IService service;

  ListItem(this.name, this.service);
}

class MyDashboardPage extends StatefulWidget {
  @override
  _MyDashboardPageState createState() => _MyDashboardPageState();
}

class _MyDashboardPageState extends State<MyDashboardPage> {
  final AreaService areaServiceInstance = AreaService();
  IService _actionService;
  IService _reactionService;
  List<DropdownMenuItem<IService>> _actionMenuItems;
  List<DropdownMenuItem<IService>> _reactionMenuItems;

  @override
  void initState() {
    super.initState();
    this._actionMenuItems = this.buildDropDownMenuItems();
    this._reactionMenuItems = this.buildDropDownMenuItems();
  }

  List<DropdownMenuItem<IService>> buildDropDownMenuItems() {
    List<DropdownMenuItem<IService>> items = List();
    for (MapEntry<ServiceType, ServiceInformation> serviceMapEntry in SERVICES_INFORMATION_MAP.entries) {
      items.add(DropdownMenuItem(
        child: Text(serviceMapEntry.value.name),
        value: serviceMapEntry.value.createServiceInstance(),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Text("ACTION", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          DropdownButton<IService>(
              value: this._actionService,
              items: this._actionMenuItems,
              onChanged: (value) {
                this.setState(() {
                  this._actionService = value;
                });
              }),
          if (this._actionService != null) this._actionService.selectAction(),
          Text("REACTION", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          DropdownButton<IService>(
              value: this._reactionService,
              items: this._reactionMenuItems,
              onChanged: (value) {
                this.setState(() {
                  this._reactionService = value;
                });
              }),
          if (this._reactionService != null) this._reactionService.selectAction(),
        ],
      ),
    ));
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
}
