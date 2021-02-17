import 'dart:async';

import 'package:area/area_services/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_page.dart';
import 'option.dart';

class GithubService extends BasePage {
  static const List<Option> ACTIONS = [
    Option("new_issue", [Input("owner", "EliottPal", null, false), Input("repo", "Dashboard_2020", null, false)]),
    Option("new_repository", [Input("owner", "EliottPal", null, false)]),
    Option("new_pull_request", [Input("owner", "EliottPal", null, false), Input("repo", "Dashboard_2020", null, false)]),
    Option("issue_closes", [Input("owner", "EliottPal", null, false), Input("repo", "Dashboard_2020", null, false)])
  ];
  static const List<Option> REACTIONS = [
    Option("open_issue", [Input("title", "Title", null, false), Input("description", "Description", null, false)])
  ];

  final StreamController<Map<String, dynamic>> streamParamsController;
  final bool isAction;
  final Map<String, dynamic> params;

  GithubService({Key key, @required this.streamParamsController, @required this.isAction, this.params = const {}}) : super(key: key);

  static create(StreamController<Map<String, dynamic>> streamParamsController, bool isAction, [params = const {}]) {
    return GithubService(streamParamsController: streamParamsController, isAction: isAction, params: params);
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
