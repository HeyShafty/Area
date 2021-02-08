import 'package:area/area_services/i_service.dart';
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

  const ServiceInformation(
      this.serviceType, this.name, this.uri, this.callbackUrlScheme, this.fullCallbackUrl, this.serverRedirectUri, this.iconPath);

  IService createServiceInstance() {
    return ServiceFactory.createServiceInstance(serviceType);
  }
}
