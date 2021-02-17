import 'dart:developer';

import 'package:area/area_form.dart';
import 'package:area/models/Area.dart';
import 'package:area/models/service_information.dart';
import 'package:area/services/area_service.dart';
import 'package:area/update_area_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

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
                children: this._isLoading && this._areaList != null
                    ? [CircularProgressIndicator()]
                    : [
                        Expanded(
                            child: ListView.builder(
                                itemCount: _areaList.length,
                                itemBuilder: (context, index) {
                                  final Area item = _areaList[index];
                                  ServiceInformation actionService;
                                  ServiceInformation reactionService;

                                  SERVICES_INFORMATION_MAP.forEach((key, value) {
                                    if (item.action.service.toLowerCase() == value.name.toLowerCase()) {
                                      actionService = value;
                                    }
                                    if (item.reaction.service.toLowerCase() == value.name.toLowerCase()) {
                                      reactionService = value;
                                    }
                                  });
                                  return Padding(
                                      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(color: Colors.black, width: 1.5), borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                              title: Row(children: [
                                                Text(actionService.name, style: TextStyle(color: Colors.black, fontSize: 20.0)),
                                                Icon(Icons.arrow_forward, color: Colors.black),
                                                Text(reactionService.name, style: TextStyle(color: Colors.black, fontSize: 20.0))
                                              ]),
                                              subtitle: Row(children: [
                                                Text(item.action.name),
                                                Icon(Icons.arrow_forward, color: Colors.grey),
                                                Text(item.reaction.name)
                                              ]),
                                              trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                                                IconButton(
                                                    icon: Icon(Icons.edit, color: Colors.black),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context, MaterialPageRoute(builder: (context) => UpdateAreaForm(item)));
                                                    }),
                                                IconButton(icon: Icon(Icons.delete_outline, color: Colors.red), onPressed: () {})
                                              ]))));
                                }))
                      ])));
  }

  navigateToForm() {
    return Navigator.push(context, MaterialPageRoute(builder: (context) => AreaFormPage()));
  }

  Future<void> getAreaList() async {
    this.setState(() {
      this._isLoading = true;
    });
    this.setState(() {
      this._isLoading = false;
      log(Map<String, String>.from({"repo": "repo"}).toString());
      this._areaList = [
        Area(AreaAction('github', 'new_issue', Map<String, dynamic>.from({"repo": "repo"})), AreaReaction('github', 'open_issue', Map())),
        Area(AreaAction('github', 'new_issue', Map<String, dynamic>.from({"repo": "repo"})), AreaReaction('github', 'open_issue', Map())),
        Area(AreaAction('github', 'new_issue', Map<String, dynamic>.from({"repo": "repo"})), AreaReaction('github', 'open_issue', Map())),
        Area(AreaAction('github', 'new_issue', Map<String, dynamic>.from({"repo": "repo"})), AreaReaction('github', 'open_issue', Map())),
      ];
    });
    /*try {
      List<Area> areaList = await areaServiceInstance.getAreaList();
      this.setState(() {
        this._isLoading = false;
        this._areaList = areaList;
      });
    } on BadTokenException {
      this.showToast("Invalid token, please sign out.");
    } on Exception {
      this.showToast("Cannot get user profile information.");
    } catch (e) {
      log(e);
      this.showToast("Cannot get user profile information.");
    }*/
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
