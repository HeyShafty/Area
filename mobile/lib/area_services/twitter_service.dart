import 'package:area/area_services/option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_page.dart';
import 'input.dart';

class TwitterService extends BasePage {
  static const List<Option> ACTIONS = [
    Option("new_tweet_from", [Input("username", "Username")]),
    Option("new_follower", [])
  ];
  static const List<Option> REACTIONS = [
    Option("post_tweet", [Input("value", "Tweet body")]),
    Option("update_bio", [Input("value", "Your new biography")])
  ];

  final Map<String, String> params;
  final bool isAction;

  TwitterService({Key key, @required this.params, @required this.isAction}) : super(key: key);

  static create(Map<String, String> params, bool isAction) {
    return TwitterService(
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
    for (Option value in REACTIONS) {
      if (value.name == reactionValue) {
        return value;
      }
    }
    return null;
  }
}
