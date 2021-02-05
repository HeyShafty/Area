class User {
  final String displayName;
  final String email;

  User(this.displayName, this.email);

  User.fromJson(Map<String, dynamic> json)
      : this.email = json['email'],
        this.displayName = json['displayName'];
}
