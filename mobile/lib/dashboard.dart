import 'dart:developer';

import 'package:area/area_form.dart';
import 'package:area/models/area.dart';
import 'package:area/models/service_information.dart';
import 'package:area/services/area_service.dart';
import 'package:area/services/toast_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'exceptions/bad_token_exception.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final AreaService areaServiceInstance = AreaService();

  bool _isLoading = true;
  List<Area> _areaList;

  @override
  void initState() {
    super.initState();
    this.getAreaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: this.navigateToForm, child: Icon(Icons.add), backgroundColor: Colors.blue),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: this._isLoading
                    ? [CircularProgressIndicator()]
                    : (this._areaList == null || this._areaList.length == 0)
                        ? [Text("Nothing to display")]
                        : [
                            Expanded(
                                child: ListView.builder(
                                    itemCount: _areaList.length,
                                    itemBuilder: (context, index) {
                                      final Area item = _areaList[index];
                                      ServiceInformation actionService;
                                      ServiceInformation reactionService;

                                      SERVICES_INFORMATION_MAP.forEach((key, value) {
                                        if (item.action.actionService.toLowerCase() == value.name.toLowerCase()) {
                                          actionService = value;
                                        }
                                        if (item.reaction.reactionService.toLowerCase() == value.name.toLowerCase()) {
                                          reactionService = value;
                                        }
                                      });
                                      return Padding(
                                          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(color: Colors.black, width: 1.5),
                                                  borderRadius: BorderRadius.circular(4.0)),
                                              child: ListTile(
                                                  title: Row(children: [
                                                    Text(actionService.name, style: TextStyle(color: Colors.black, fontSize: 20.0)),
                                                    Icon(Icons.arrow_forward, color: Colors.black),
                                                    Text(reactionService.name, style: TextStyle(color: Colors.black, fontSize: 20.0))
                                                  ]),
                                                  subtitle: Row(children: [
                                                    Text(item.action.actionName),
                                                    Icon(Icons.arrow_forward, color: Colors.grey),
                                                    Text(item.reaction.reactionName)
                                                  ]),
                                                  trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                                                    IconButton(
                                                        icon: Icon(Icons.edit, color: Colors.black),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context, MaterialPageRoute(builder: (context) => AreaFormPage(area: item)));
                                                        }),
                                                    IconButton(icon: Icon(Icons.delete_outline, color: Colors.red), onPressed: () {})
                                                  ]))));
                                    }))
                          ])));
  }

  navigateToForm() {
    return Navigator.push(context, MaterialPageRoute(builder: (context) => AreaFormPage())).then((value) => this.getAreaList());
  }

  Future<void> getAreaList() async {
    this.setState(() {
      this._isLoading = true;
    });
/*    this.setState(() {
      this._isLoading = false;
      this._areaList = [
        Area(AreaAction('github', 'new_issue', Map<String, dynamic>.from({"repo": "repo"})), AreaReaction('github', 'open_issue', Map())),
        Area(AreaAction('github', 'new_issue', Map<String, dynamic>.from({"repo": "repo"})), AreaReaction('github', 'open_issue', Map())),
        Area(AreaAction('github', 'new_issue', Map<String, dynamic>.from({"repo": "repo"})), AreaReaction('github', 'open_issue', Map())),
        Area(AreaAction('github', 'new_issue', Map<String, dynamic>.from({"repo": "repo"})), AreaReaction('github', 'open_issue', Map())),
      ];
    });*/
    try {
      List<Area> areaList = await areaServiceInstance.getAreaList();
      this.setState(() {
        this._isLoading = false;
        this._areaList = areaList;
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
