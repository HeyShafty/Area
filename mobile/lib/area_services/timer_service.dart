import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'base_page.dart';
import 'option.dart';

class TimerService extends BasePage {
  static const List<Option> ACTIONS = [Option("every_hour", []), Option("every_day", [])];
  static const List<Option> REACTIONS = [];

  final StreamController<Map<String, String>> streamParamsController;
  final bool isAction;
  final Map<String, String> params;

  TimerService({Key key, @required this.streamParamsController, @required this.isAction, this.params = const {}}) : super(key: key);

  static create(StreamController<Map<String, String>> streamParamsController, bool isAction, [params = const {}]) {
    return TimerService(streamParamsController: streamParamsController, isAction: isAction, params: params);
  }

  @override
  BaseState createState() => BaseState(streamParamsController, isAction, ACTIONS, REACTIONS, params);

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
