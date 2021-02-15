import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_page.dart';
import 'input.dart';
import 'option.dart';

class GoogleService extends BasePage {
  static const List<Option> ACTIONS = [
    Option("new_video", [Input("channel", "Channel name", null)]),
    Option("playlist_update", [Input("playlist", "Playlist name", null)])
  ];
  static const List<Option> REACTIONS = [];

  final StreamController<Map<String, String>> streamParams;
  final bool isAction;

  GoogleService({Key key, @required this.streamParams, @required this.isAction}) : super(key: key);

  static create(StreamController<Map<String, String>> streamParams, bool isAction) {
    return GoogleService(
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
    return null;
  }
}
