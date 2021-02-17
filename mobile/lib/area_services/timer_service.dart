import 'dart:async';

import 'package:area/area_services/input.dart';
import 'package:flutter/cupertino.dart';

import 'base_page.dart';
import 'option.dart';

class TimerService extends BasePage {
  static const List<Option> ACTIONS = [
    Option("every_hour", [Input('minute', '42', r'[0-5]?[0-9]$', true)]),
    Option("every_day", [Input('hour', '10', r'^([0-1]?[0-9]|2[0-3])$', true)])
  ];
  static const List<Option> REACTIONS = [];

  final StreamController<Map<String, dynamic>> streamParamsController;
  final bool isAction;
  final Map<String, dynamic> params;

  TimerService({Key key, @required this.streamParamsController, @required this.isAction, this.params = const {}}) : super(key: key);

  static create(StreamController<Map<String, dynamic>> streamParamsController, bool isAction, [params = const {}]) {
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
