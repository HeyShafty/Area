import 'dart:async';

import 'package:area/area_services/option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_page.dart';
import 'input.dart';

class TwitterService extends BasePage {
  static const List<Option> ACTIONS = [
    Option("new_tweet_from", [Input("username", "Username", r'(?<=^|(?<=[^a-zA-Z0-9-_\.]))@([A-Za-z]+[A-Za-z0-9-_]+)')]),
    Option("new_follower", [])
  ];
  static const List<Option> REACTIONS = [
    Option("post_tweet", [Input("value", "Tweet body", null)]),
    Option("update_bio", [Input("value", "Your new biography", null)])
  ];

  final StreamController<Map<String, String>> streamParams;
  final bool isAction;

  TwitterService({Key key, @required this.streamParams, @required this.isAction}) : super(key: key);

  static create(StreamController<Map<String, String>> streamParams, bool isAction) {
    return TwitterService(
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
