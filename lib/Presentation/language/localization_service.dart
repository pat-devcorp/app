class LocalizationService {
  final String userLabel;
  final String passwordLabel;
  final String loginButtonLabel;
  final String welcomeMessage;
  final String logoutButtonLabel;
  final String operationSuccess;
  final String operationError;

  LocalizationService({
    required this.userLabel,
    required this.passwordLabel,
    required this.loginButtonLabel,
    required this.welcomeMessage,
    required this.logoutButtonLabel,
    required this.operationSuccess,
    required this.operationError,
  });

  // Factory constructor to create an instance from a JSON map
  factory LocalizationService.fromJson(Map<String, dynamic> json) {
    return LocalizationService(
      userLabel: json['userLabel'] ?? 'User',
      passwordLabel: json['passwordLabel'] ?? 'Password',
      loginButtonLabel: json['loginButtonLabel'] ?? 'Login',
      welcomeMessage: json['welcomeMessage'] ?? 'Welcome',
      logoutButtonLabel: json['logoutButtonLabel'] ?? 'Logout',
      operationSuccess: json['operationSuccess'] ?? "Operation Successful!",
      operationError: json['operationError'] ?? "Something went wrong!",
    );
  }
}
