import 'dart:async';

import 'package:area/area_services/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_page.dart';
import 'option.dart';

class GithubService extends BasePage {
  static const List<Option> ACTIONS = [
    Option("new_issue", [Input("repo", "Repository", null)]),
    Option("new_repository", []),
    Option("new_pull_request", [Input("repo", "Repository", null)]),
    Option("issue_closes", [Input("repo", "Repository", null)])
  ];
  static const List<Option> REACTIONS = [
    Option("open_issue", [Input("title", "Title", null), Input("description", "Description", null)])
  ];

  final StreamController<Map<String, String>> streamParams;
  final bool isAction;

  GithubService({Key key, @required this.streamParams, @required this.isAction}) : super(key: key);

  static create(StreamController<Map<String, String>> streamParams, bool isAction) {
    return GithubService(
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
