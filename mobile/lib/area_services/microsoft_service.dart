import 'dart:async';

import 'package:area/area_services/input.dart';
import 'package:area/area_services/option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_page.dart';

class MicrosoftService extends BasePage {
  static const List<Option> ACTIONS = [Option("incoming_mail", [])];
  static const List<Option> REACTIONS = [
    Option("send_mail", [Input("object", "Object"), Input("body", "Body")])
  ];

  final StreamController<Map<String, String>> streamParams;
  final bool isAction;

  MicrosoftService({Key key, @required this.streamParams, @required this.isAction}) : super(key: key);

  static create(StreamController<Map<String, String>> streamParams, bool isAction) {
    return MicrosoftService(
      streamParams: streamParams,
      isAction: isAction,
    );
  }

  @override
  BaseState createState() => BaseState(streamParams, isAction, ACTIONS, REACTIONS);

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
