import 'package:area/area_services/input.dart';
import 'package:area/area_services/option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_page.dart';

class DiscordService extends BasePage {
  static const List<Option> ACTIONS = [];
  static const List<Option> REACTIONS = [
    Option("post_message", [Input("webhook", "Webhook"), Input("message", "Message")])
  ];

  final Map<String, String> params;
  final bool actionMode;

  DiscordService({Key key, @required this.params, @required this.actionMode}) : super(key: key);

  static create(Map<String, String> params, bool isAction) {
    return DiscordService(
      params: params,
      actionMode: isAction,
    );
  }

  @override
  BaseState createState() => BaseState(params, actionMode, ACTIONS, REACTIONS);

  @override
  Option getActionOption(String actionValue) {
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
