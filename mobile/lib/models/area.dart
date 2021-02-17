import 'dart:convert';

class AreaAction {
  final String actionService;
  final String actionName;
  final Map<String, dynamic> data;

  AreaAction(this.actionService, this.actionName, this.data);

  AreaAction.fromJson(Map<String, dynamic> json)
      : actionService = json['service'],
        actionName = json['name'],
        data = json['data'];

  Map<String, dynamic> toJson() => {
        'actionService': actionService,
        'actionName': actionName,
        'data': jsonEncode(data),
      };
}

class AreaReaction {
  final String reactionService;
  final String reactionName;
  final Map<String, dynamic> data;

  AreaReaction(this.reactionService, this.reactionName, this.data);

  AreaReaction.fromJson(Map<String, dynamic> json)
      : reactionService = json['service'],
        reactionName = json['name'],
        data = json['data'];

  Map<String, dynamic> toJson() => {
        'reactionService': reactionService,
        'reactionName': reactionName,
        'data': jsonEncode(data),
      };
}

class Area {
  final AreaAction action;
  final AreaReaction reaction;

  Area(this.action, this.reaction);

  Area.fromJson(Map<String, dynamic> json)
      : action = AreaAction.fromJson(json['action']),
        reaction = AreaReaction.fromJson(json['reaction']);

  Map<String, dynamic> toJson() => {
        'action': action.toJson(),
        'reaction': reaction.toJson(),
      };
}
