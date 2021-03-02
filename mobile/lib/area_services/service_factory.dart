import 'dart:async';

import 'package:area/area_services/discord_service.dart';
import 'package:area/area_services/github_service.dart';
import 'package:area/area_services/microsoft_service.dart';
import 'package:area/area_services/timer_service.dart';
import 'package:area/area_services/twitter_service.dart';
import 'package:area/area_services/youtube_service.dart';

import 'area_service_base.dart';

class ServiceFactory {
  static const Map<String, Function> SERVICE_FACTORY_MAP = {
    "discord": DiscordService.create,
    "github": GithubService.create,
    "youtube": YoutubeService.create,
    "microsoft": MicrosoftService.create,
    "timer": TimerService.create,
    "twitter": TwitterService.create
  };

  static AreaServiceBase createServiceInstance(
      String serviceName, StreamController<Map<String, dynamic>> streamParamsController, bool isAction,
      [Map<String, dynamic> params = const {}]) {
    return SERVICE_FACTORY_MAP[serviceName](streamParamsController, isAction, params);
  }
}
