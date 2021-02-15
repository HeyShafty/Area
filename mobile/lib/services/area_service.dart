import 'dart:convert';
import 'dart:developer';

import 'package:area/exceptions/already_exists_exception.dart';
import 'package:area/exceptions/bad_response_exception.dart';
import 'package:area/exceptions/bad_token_exception.dart';
import 'package:area/exceptions/wrong_email_password_combination_exception.dart';
import 'package:area/models/service_information.dart';
import 'package:area/models/user.dart';
import 'package:area/services/shared_preferences_service.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

enum ServiceType { DISCORD, GITHUB, GOOGLE, MICROSOFT, TWITTER, TIMER }

class AreaService {
  static final AreaService _singleton = AreaService._internal();

  String accessToken = "";
  String _serverIp = "";

  String get serverIp => _serverIp;

  set serverIp(String serverIp) {
    if (serverIp.endsWith("/")) {
      serverIp = serverIp.substring(0, serverIp.length - 1);
    }
    _serverIp = serverIp;
  }

  factory AreaService() {
    return _singleton;
  }

  Future<bool> getStoredAccessToken() async {
    String accessToken = await SharedPreferencesService.getString(TOKEN_KEY);

    if (accessToken == null || accessToken == "") {
      return false;
    }
    this.accessToken = accessToken;
    return true;
  }

  Future<void> checkIp() async {
    http.Response response = await http.get("http://" + this.serverIp).timeout(const Duration(seconds: 3));

    if (response.statusCode != 200) {
      throw BadResponseException();
    }
  }

  Future<void> signInWithAccessToken(String token) async {
    http.Response response = await http.post("http://" + this.serverIp + "/auth/office-jwt",
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ' + token});
    if (response.statusCode != 200) {
      throw BadResponseException();
    }

    final Map<String, dynamic> decodedBody = jsonDecode(response.body);
    this.accessToken = decodedBody[TOKEN_KEY] ?? (throw BadResponseException(cause: "Wrong response body."));
    await SharedPreferencesService.saveString(TOKEN_KEY, this.accessToken);
  }

  Future<void> signInWithCredentials(String email, String password) async {
    http.Response response = await http.post("http://" + this.serverIp + "/auth/sign-in",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"email": email, "password": password}));
    if (response.statusCode == 401) {
      throw WrongEmailPasswordCombinationException();
    }
    if (response.statusCode != 200) {
      throw BadResponseException();
    }

    final Map<String, dynamic> decodedBody = jsonDecode(response.body);
    this.accessToken = decodedBody[TOKEN_KEY] ?? (throw BadResponseException(cause: "Wrong response body."));
    await SharedPreferencesService.saveString(TOKEN_KEY, this.accessToken);
  }

  Future<void> signUp(String username, String email, String password) async {
    http.Response response = await http.post("http://" + this.serverIp + "/auth/sign-up",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"email": email, "password": password, "username": username}));
    if (response.statusCode == 409) {
      throw AlreadyExistsException();
    }
    if (response.statusCode != 200) {
      throw BadResponseException();
    }

    final Map<String, dynamic> decodedBody = jsonDecode(response.body);
    this.accessToken = decodedBody[TOKEN_KEY] ?? (throw BadResponseException(cause: "Wrong response body."));
    await SharedPreferencesService.saveString(TOKEN_KEY, this.accessToken);
  }

  Future<String> getServiceRedirectionUrl(ServiceInformation service) async {
    String serviceRedirectUri = service.uri;
    Uri uri = Uri.http(this.serverIp, serviceRedirectUri, {'mobile': 'true'});
    log(uri.toString());
    http.Response response = await http.get(uri, headers: <String, String>{"Authorization": 'Bearer ' + this.accessToken});
    if (response.statusCode == 401) {
      throw BadTokenException();
    }
    if (response.statusCode != 200) {
      throw BadResponseException();
    }

    final Map<String, dynamic> decodedBody = jsonDecode(response.body);
    return decodedBody[CONNECT_URL_KEY] ?? (throw BadResponseException(cause: "Wrong response body."));
  }

  Future<void> handleServiceRedirection(String callbackUrl, ServiceInformation service) async {
    if (!callbackUrl.contains(service.fullCallbackUrl)) {
      throw BadResponseException(cause: "Bad redirect URI");
    }

    Uri uri = Uri.parse("http://" + this._serverIp + service.serverRedirectUri + callbackUrl.split(service.fullCallbackUrl)[1]);
    http.Response response = await http.get(uri.toString());
    if (response.statusCode != 200) {
      throw BadResponseException();
    }
  }

  Future<User> getUserProfile() async {
    http.Response response =
        await http.get("http://" + this._serverIp + "/profile", headers: <String, String>{"Authorization": 'Bearer ' + this.accessToken});
    if (response.statusCode == 401) {
      throw BadTokenException();
    }
    if (response.statusCode != 200) {
      throw BadResponseException();
    }
    return User.fromJson(jsonDecode(response.body));
  }

  Future<bool> isConnectedToService(String name) async {
    User user = await this.getUserProfile();
    return user.servicesConnectInformation.contains(name.toLowerCase());
  }

  AreaService._internal();
}
