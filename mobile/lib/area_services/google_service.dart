import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_page.dart';
import 'input.dart';
import 'option.dart';

class GoogleService extends BasePage {
  static const List<Option> ACTIONS = [
    Option("new_video", [Input("channel", "Channel name")]),
    Option("playlist_update", [Input("playlist", "Playlist name")])
  ];
  static const List<Option> REACTIONS = [];

  final Map<String, String> params;
  final bool isAction;

  GoogleService({Key key, @required this.params, @required this.isAction}) : super(key: key);

  static create(Map<String, String> params, bool isAction) {
    return GoogleService(
      params: params,
      isAction: isAction,
    );
  }

  @override
  BaseState createState() => BaseState(params, isAction, ACTIONS, REACTIONS);

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
    return null;
  }
}
