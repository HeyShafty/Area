import 'package:area/area_services/discord_service.dart';
import 'package:area/area_services/github_service.dart';
import 'package:area/area_services/google_service.dart';
import 'package:area/area_services/microsoft_service.dart';
import 'package:area/area_services/twitter_service.dart';
import 'package:area/services/area_service.dart';

import 'i_service.dart';

class ServiceFactory {
  static const Map<ServiceType, Function> SERVICE_FACTORY_MAP = {
    ServiceType.DISCORD: DiscordService.create,
    ServiceType.GITHUB: GithubService.create,
    ServiceType.GOOGLE: GoogleService.create,
    ServiceType.MICROSOFT: MicrosoftService.create,
    ServiceType.TWITTER: TwitterService.create,
  };

  static IService createServiceInstance(ServiceType serviceType) {
    return SERVICE_FACTORY_MAP[serviceType]();
  }
}
