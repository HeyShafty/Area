import 'dart:async';

import 'package:area/area_services/discord_service.dart';
import 'package:area/area_services/github_service.dart';
import 'package:area/area_services/google_service.dart';
import 'package:area/area_services/microsoft_service.dart';
import 'package:area/area_services/timer_service.dart';
import 'package:area/area_services/twitter_service.dart';
import 'package:area/services/area_service.dart';

import 'base_page.dart';

class ServiceFactory {
  static const Map<ServiceType, Function> SERVICE_FACTORY_MAP = {
    ServiceType.DISCORD: DiscordService.create,
    ServiceType.GITHUB: GithubService.create,
    ServiceType.GOOGLE: GoogleService.create,
    ServiceType.MICROSOFT: MicrosoftService.create,
    ServiceType.TWITTER: TwitterService.create,
    ServiceType.TIMER: TimerService.create
  };

  static BasePage createServiceInstance(
      ServiceType serviceType, StreamController<Map<String, String>> streamParamsController, bool isAction,
      [Map<String, String> params = const {}]) {
    return SERVICE_FACTORY_MAP[serviceType](streamParamsController, isAction, params);
  }
}
