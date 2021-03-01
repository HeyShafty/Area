class User {
  final String displayName;
  final String email;
  final List<String> servicesConnectInformation;

  User(this.displayName, this.email, this.servicesConnectInformation);

  User.fromJson(Map<String, dynamic> json)
      : this.email = json['email'],
        this.displayName = json['displayName'],
        this.servicesConnectInformation = (json['connectData'] as List).map((i) => i.toString()).toList();
}
