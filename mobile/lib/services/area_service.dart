class AreaService {
  static final AreaService _singleton = AreaService._internal();

  String get accessToken => accessToken;

  set accessToken(String value) => accessToken = value;

  factory AreaService() {
    return _singleton;
  }

  void signInWithAccessToken(String token) {}

  void signInWithCredentials(String email, String password) {}

  void signUp(String username, String email, String password) {}

  AreaService._internal();
}