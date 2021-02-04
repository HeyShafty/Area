class Service {
  final String name;
  final String uri;
  final String callbackUrlScheme;
  final String fullCallbackUrl;
  final String serverRedirectUri;
  final String iconPath;

  const Service(this.name, this.uri, this.callbackUrlScheme, this.fullCallbackUrl, this.serverRedirectUri, this.iconPath);
}
