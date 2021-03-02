import 'dart:async';

import 'package:area/area_services/input.dart';
import 'package:area/area_services/option.dart';
import 'package:area/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'area_service_base.dart';

class MicrosoftService extends AreaServiceBase {
  static const List<Option> ACTIONS = [Option("incoming_mail", [])];
  static const List<Option> REACTIONS = [
    Option(
        "send_mail", [Input("to", "To", EMAIL_REGEX, false), Input("subject", "Subject", null, false), Input("body", "Body", null, false)])
  ];

  final StreamController<Map<String, dynamic>> streamParamsController;
  final bool isAction;
  final Map<String, dynamic> params;

  MicrosoftService({Key key, @required this.streamParamsController, @required this.isAction, this.params = const {}}) : super(key: key);

  static create(StreamController<Map<String, dynamic>> streamParamsController, bool isAction, [params = const {}]) {
    return MicrosoftService(streamParamsController: streamParamsController, isAction: isAction, params: params);
  }

  @override
  AreaServiceBaseState createState() => AreaServiceBaseState(streamParamsController, isAction, ACTIONS, REACTIONS, params);

  @override
  Option getActionOption(String actionValue) {
    for (Option value in ACTIONS) {
      if (value.name == actionValue) {
        return value;
      }
    }
    return null;
  }

  @override
  Option getReactionOption(String reactionValue) {
    for (Option value in REACTIONS) {
      if (value.name == reactionValue) {
        return value;
      }
    }
    return null;
  }
}