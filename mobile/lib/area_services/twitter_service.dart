import 'dart:async';

import 'package:area/area_services/option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'area_service_base.dart';
import 'input.dart';

class TwitterService extends AreaServiceBase {
  static const List<Option> ACTIONS = [
    Option("new_tweet_from", [Input("username", "Username", r'(?<=^|(?<=[^a-zA-Z0-9-_\.]))@([A-Za-z]+[A-Za-z0-9-_]+)', false)]),
    Option("new_follower", [])
  ];
  static const List<Option> REACTIONS = [
    Option("post_tweet", [Input("body", "Tweet body", null, false)]),
    Option("update_bio", [Input("body", "Your new biography", null, false)])
  ];

  final StreamController<Map<String, dynamic>> streamParamsController;
  final bool isAction;
  final Map<String, dynamic> params;

  TwitterService({Key key, @required this.streamParamsController, @required this.isAction, this.params = const {}}) : super(key: key);

  static create(StreamController<Map<String, dynamic>> streamParamsController, bool isAction, [params = const {}]) {
    return TwitterService(streamParamsController: streamParamsController, isAction: isAction, params: params);
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
