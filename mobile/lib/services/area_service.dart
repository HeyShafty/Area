import 'dart:convert';

import 'package:area/services/shared_preferences_service.dart';
import 'package:http/http.dart' as http;

class AreaService {
  static const String TOKEN_KEY = "token";
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
      throw ("Bad ip address.");
    }
  }

  Future<void> signInWithAccessToken(String token) async {
    http.Response response = await http.get("http://" + this.serverIp + "/auth/office-jwt",
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ' + token});
    if (response.statusCode != 200) {
      throw ("Couldn't sign you in with Microsoft.");
    }

    final Map<String, dynamic> decodedBody = jsonDecode(response.body);
    if (decodedBody[TOKEN_KEY] == "") {
      throw ("Couldn't sign you in with Microsoft.");
    }
    this.accessToken = decodedBody[TOKEN_KEY];
    await SharedPreferencesService.saveString(TOKEN_KEY, this.accessToken);
  }

  Future<void> signInWithCredentials(String email, String password) async {
    http.Response response = await http.post("http://" + this.serverIp + "/auth/sign-in",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"email": email, "password": password}));
    if (response.statusCode == 401) {
      throw ("Wrong email/password combination.");
    }
    if (response.statusCode != 200) {
      throw ("Couldn't sign you in.");
    }

    final Map<String, dynamic> decodedBody = jsonDecode(response.body);
    if (decodedBody[TOKEN_KEY] == "") {
      throw ("Couldn't sign you in.");
    }
    this.accessToken = decodedBody[TOKEN_KEY];
    await SharedPreferencesService.saveString(TOKEN_KEY, this.accessToken);
  }

  Future<void> signUp(String username, String email, String password) async {
    http.Response response = await http.post("http://" + this.serverIp + "/auth/sign-up",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"email": email, "password": password, "fullName": username}));
    if (response.statusCode == 409) {
      throw ("Email already exists.");
    }
    if (response.statusCode != 200) {
      throw ("Couldn't sign you up.");
    }

    final Map<String, dynamic> decodedBody = jsonDecode(response.body);
    if (decodedBody[TOKEN_KEY] == "") {
      throw ("Couldn't sign you up.");
    }
    this.accessToken = decodedBody[TOKEN_KEY];
    await SharedPreferencesService.saveString(TOKEN_KEY, this.accessToken);
  }

  AreaService._internal();
}
