import 'dart:async';

import 'package:area/area_services/area_service_base.dart';
import 'package:area/area_services/service_factory.dart';
import 'package:area/services/area_service.dart';

class ServiceInformation {
  final ServiceType serviceType;
  final String name;
  final String uri;
  final String callbackUrlScheme;
  final String fullCallbackUrl;
  final String serverRedirectUri;
  final String iconPath;
  final bool hasActions;
  final bool hasReactions;

  const ServiceInformation(this.serviceType, this.name, this.uri, this.callbackUrlScheme, this.fullCallbackUrl, this.serverRedirectUri,
      this.iconPath, this.hasActions, this.hasReactions);

  AreaServiceBase createServiceInstance(StreamController<Map<String, dynamic>> streamParamsController, bool isAction,
      [Map<String, dynamic> params = const {}]) {
    return ServiceFactory.createServiceInstance(serviceType, streamParamsController, isAction, params);
  }
}
