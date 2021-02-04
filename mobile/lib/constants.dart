import 'package:area/Models/service.dart';
import 'package:area/services/area_service.dart';

const String EMAIL_REGEX =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const String IP_KEY = "IP";
const String TOKEN_KEY = "token";
const String TENANT_ID = "901cb4ca-b862-4029-9306-e5cd0f6d9f86";
const String APP_ID = "24ffcb55-7348-48a4-bbe7-c6c5b3763578";
const String SERVER_SCOPE = "api://a8dcacc9-80da-4a2b-9f8a-6e20221951d0/user.base.read";
const String CONNECT_URL_KEY = "url";
const Map<ServiceType, Service> SERVICES_CONNECT_URI = {
  ServiceType.DISCORD:
      Service('Discord', '/connect/discord', 'area.app', 'area.app://auth', '/connect/discord/callback', 'assets/images/discord.png'),
  ServiceType.GITHUB:
      Service('Github', '/connect/github', 'area.app', 'area.app://auth', '/connect/github/callback', 'assets/images/github.png'),
  ServiceType.GOOGLE:
      Service('Google', '/connect/google', 'area.app', 'area.app:/auth', '/connect/google/callback', 'assets/images/google.png'),
  ServiceType.MICROSOFT: Service('Microsoft', '/connect/microsoft', 'msauth.area.app', 'msauth.area.app://auth',
      '/connect/microsoft/callback', 'assets/images/microsoft.png'),
  ServiceType.TWITTER:
      Service('Twitter', '/connect/twitter', 'area.app', 'area.app://auth', '/connect/twitter/callback', 'assets/images/twitter.png'),
};
