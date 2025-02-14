class LocalizationService {
  final String loginButtonLabel;
  final String welcomeMessage;
  final String logoutButtonLabel;

  LocalizationService({
    required this.loginButtonLabel,
    required this.welcomeMessage,
    required this.logoutButtonLabel,
  });

  // Factory constructor to create an instance from a JSON map
  factory LocalizationService.fromJson(Map<String, dynamic> json) {
    return LocalizationService(
      loginButtonLabel: json['loginButtonLabel'] ?? 'Login',
      welcomeMessage: json['welcomeMessage'] ?? 'Welcome',
      logoutButtonLabel: json['logoutButtonLabel'] ?? 'Logout',
    );
  }
}
