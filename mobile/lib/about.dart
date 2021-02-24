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

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState<Page extends AboutPage> extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: this.getFormTitle(),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Column(children: [
          Text("Nothing to display", style: TextStyle(fontSize: 20.0))
        ]))));
  }

  Widget getFormTitle() {
    return Text('About Page');
  }
}
