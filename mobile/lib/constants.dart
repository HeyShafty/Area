import 'package:area/area_services/discord_service.dart';
import 'package:area/area_services/github_service.dart';
import 'package:area/area_services/google_service.dart';
import 'package:area/area_services/microsoft_service.dart';
import 'package:area/area_services/timer_service.dart';
import 'package:area/area_services/twitter_service.dart';
import 'package:area/models/service.dart';

const String EMAIL_REGEX =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const String IP_KEY = "IP";
const String TOKEN_KEY = "token";
const String TENANT_ID = "901cb4ca-b862-4029-9306-e5cd0f6d9f86";
const String APP_ID = "24ffcb55-7348-48a4-bbe7-c6c5b3763578";
const String SERVER_SCOPE = "api://a8dcacc9-80da-4a2b-9f8a-6e20221951d0/user.base.read";
const String CONNECT_URL_KEY = "url";
const Map<String, Service> SERVICES_MAP = {
  "discord": DiscordService(),
  "github": GithubService(),
  "google": GoogleService(),
  "microsoft": MicrosoftService(),
  "timer": TimerService(),
  "twitter": TwitterService()
};
const String ACTION_KEY = "action";
const String REACTION_KEY = "reaction";
const String DISCORD_BOT_LINK = "https://discord.com/api/oauth2/authorize?client_id=813355775825149962&permissions=2048&scope=bot";
