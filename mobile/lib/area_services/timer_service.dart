import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'base_page.dart';
import 'option.dart';

class TimerService extends BasePage {
  static const List<Option> ACTIONS = [Option("every_hour", []), Option("every_day", [])];
  static const List<Option> REACTIONS = [];

  final StreamController<Map<String, String>> streamParams;
  final bool isAction;

  TimerService({Key key, @required this.streamParams, @required this.isAction}) : super(key: key);

  static create(StreamController<Map<String, String>> streamParams, bool isAction) {
    return TimerService(
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
