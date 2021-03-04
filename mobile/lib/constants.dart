import 'package:area/models/service_information.dart';

const String EMAIL_REGEX =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const String IP_KEY = "IP";
const String TOKEN_KEY = "token";
const String TENANT_ID = "901cb4ca-b862-4029-9306-e5cd0f6d9f86";
const String APP_ID = "24ffcb55-7348-48a4-bbe7-c6c5b3763578";
const String SERVER_SCOPE = "api://a8dcacc9-80da-4a2b-9f8a-6e20221951d0/user.base.read";
const String CONNECT_URL_KEY = "url";
const Map<String, ServiceInformation> SERVICES_INFORMATION_MAP = {
  "discord": ServiceInformation('Discord', null, null, null, null, null, false, true),
  "github": ServiceInformation(
      'Github', '/connect/github', 'area.app', 'area.app://auth', '/connect/github/callback', 'assets/images/github.png', true, true),
  "google": ServiceInformation(
      'Google', '/connect/google', 'area.app', 'area.app:/auth', '/connect/google/callback', 'assets/images/google.png', true, false),
  "microsoft": ServiceInformation('Microsoft', '/connect/microsoft', 'msauth.area.app', 'msauth.area.app://auth',
      '/connect/microsoft/callback', 'assets/images/microsoft.png', true, true),
  "timer": ServiceInformation('Timer', null, null, null, null, null, true, false),
  "twitter": ServiceInformation(
      'Twitter', '/connect/twitter', 'area.app', 'area.app://', '/connect/twitter/callback', 'assets/images/twitter.png', false, true)
};
const String ACTION_KEY = "action";
const String REACTION_KEY = "reaction";
const String DISCORD_BOT_LINK = "https://discord.com/api/oauth2/authorize?client_id=813355775825149962&permissions=2048&scope=bot";
