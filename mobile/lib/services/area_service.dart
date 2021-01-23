import 'dart:convert';

import 'package:http/http.dart' as http;

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

  Future<void> signInWithAccessToken(String token) async {
    http.Response response = await http.get("http://" + serverIp + "/auth/office-jwt", headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token
    });
    if (response.statusCode != 200) {
      throw ("Couldn't sign you in with Microsoft.");
    }

    final Map<String, dynamic> decodedBody = jsonDecode(response.body);
    if (decodedBody["token"] == "") {
      throw ("Couldn't sign you in with Microsoft.");
    }
    this.accessToken = decodedBody["token"];
  }

  Future<void> signInWithCredentials(String email, String password) async {
    http.Response response = await http.post("http://" + serverIp + "/auth/sign-in",
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
    if (decodedBody["token"] == "") {
      throw ("Couldn't sign you in.");
    }
    this.accessToken = decodedBody["token"];
  }

  Future<void> signUp(String username, String email, String password) async {
    http.Response response = await http.post("http://" + serverIp + "/auth/sign-up",
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
    if (decodedBody["token"] == "") {
      throw ("Couldn't sign you up.");
    }
    this.accessToken = decodedBody["token"];
  }

  AreaService._internal();
}
