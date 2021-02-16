class AreaAction {
  final String service;
  final String name;

  AreaAction(this.service, this.name);

  AreaAction.fromJson(Map<String, dynamic> json)
      : service = json['service'],
        name = json['name'];
}

class AreaReaction {
  final String service;
  final String name;

  AreaReaction(this.service, this.name);

  AreaReaction.fromJson(Map<String, dynamic> json)
      : service = json['service'],
        name = json['name'];
}

class Area {
  final AreaAction action;
  final AreaReaction reaction;

  Area(this.action, this.reaction);

  Area.fromJson(Map<String, dynamic> json)
      : action = AreaAction.fromJson(json['service']),
        reaction = AreaReaction.fromJson(json['name']);
}
