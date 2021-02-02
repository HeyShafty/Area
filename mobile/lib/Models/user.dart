class User {
  final String username;
  final String email;
  final bool github;
  final bool microsoft;
  final bool twitter;
  final bool google;

  User(this.username, this.email, this.github, this.microsoft, this.twitter, this.google);

  User.fromJson(Map<String, dynamic> json)
      : this.email = json['email'],
        this.username = json['username'],
        this.github = json['github'],
        this.google = json['google'],
        this.microsoft = json['microsoft'],
        this.twitter = json['twitter'];
}
