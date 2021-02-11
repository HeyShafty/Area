import 'package:area/area_services/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_page.dart';
import 'option.dart';

class GithubService extends BasePage {
  static const List<Option> ACTIONS = [
    Option("new_issue", [Input("repo", "Repository")]),
    Option("new_repository", []),
    Option("new_pull_request", [Input("repo", "Repository")]),
    Option("issue_closes", [Input("repo", "Repository")])
  ];
  static const List<Option> REACTIONS = [
    Option("open_issue", [Input("title", "Title"), Input("description", "Description")])
  ];

  final Map<String, String> params;
  final bool isAction;

  GithubService({Key key, @required this.params, @required this.isAction}) : super(key: key);

  static create(Map<String, String> params, bool isAction) {
    return GithubService(
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
