import 'dart:async';

import 'package:area/area_services/discord_service_widget.dart';
import 'package:area/area_services/github_service_widget.dart';
import 'package:area/area_services/google_service_widget.dart';
import 'package:area/area_services/microsoft_service_widget.dart';
import 'package:area/area_services/timer_service_widget.dart';
import 'package:area/area_services/twitter_service_widget.dart';

import 'area_service_widget_base.dart';

class ServiceWidgetFactory {
  static const Map<String, Function> SERVICE_FACTORY_MAP = {
    "discord": DiscordServiceWidget.create,
    "github": GithubServiceWidget.create,
    "google": GoogleServiceWidget.create,
    "microsoft": MicrosoftServiceWidget.create,
    "timer": TimerServiceWidget.create,
    "twitter": TwitterServiceWidget.create
  };

  static AreaServiceWidgetBase createServiceWidgetInstance(
      String serviceName, StreamController<Map<String, dynamic>> streamParamsController, bool isAction,
      [Map<String, dynamic> params = const {}]) {
    return SERVICE_FACTORY_MAP[serviceName](streamParamsController, isAction, params);
  }
}
