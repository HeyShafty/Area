class AreaAction {
  final String service;
  final String name;
  final Map<String, dynamic> data;

  AreaAction(this.service, this.name, this.data);

  AreaAction.fromJson(Map<String, dynamic> json)
      : service = json['service'],
        name = json['name'],
        data = json['data'];
}

class AreaReaction {
  final String service;
  final String name;
  final Map<String, dynamic> data;

  AreaReaction(this.service, this.name, this.data);

  AreaReaction.fromJson(Map<String, dynamic> json)
      : service = json['service'],
        name = json['name'],
        data = json['data'];
}

class Area {
  final AreaAction action;
  final AreaReaction reaction;

  Area(this.action, this.reaction);

  Area.fromJson(Map<String, dynamic> json)
      : action = AreaAction.fromJson(json['service']),
        reaction = AreaReaction.fromJson(json['name']);
}
