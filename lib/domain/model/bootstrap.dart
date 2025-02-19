class Bootstrap {
  String appVersion;
  String apiHost;

  Bootstrap({
    required this.appVersion,
    required this.apiHost,
  });

  @override
  String toString() {
    return 'Bootstrap{appVersion: $appVersion, apiHost: $apiHost}';
  }
}
