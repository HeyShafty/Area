import 'dart:async';

import 'package:area/area_services/area_service_widget_base.dart';
import 'package:area/area_services/service_factory.dart';

class Service {
  final String name;
  final String uri;
  final String callbackUrlScheme;
  final String fullCallbackUrl;
  final String serverRedirectUri;
  final String iconPath;
  final bool hasActions;
  final bool hasReactions;

  const Service(this.name, this.uri, this.callbackUrlScheme, this.fullCallbackUrl, this.serverRedirectUri, this.iconPath, this.hasActions,
      this.hasReactions);

  AreaServiceWidgetBase createServiceWidgetInstance(StreamController<Map<String, dynamic>> streamParamsController, bool isAction,
      [Map<String, dynamic> params = const {}]) {
    return ServiceFactory.createServiceWidgetInstance(this.name.toLowerCase(), streamParamsController, isAction, params);
  }
}
