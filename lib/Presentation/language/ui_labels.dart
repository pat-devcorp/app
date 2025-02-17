class UiLabels {
  final String menuItemHome;
  final String menuItemSettings;
  final String tittleLoginForm;
  final String inputUserLabel;
  final String inputPasswordLabel;
  final String loginButtonLabel;
  final String welcomeMessage;
  final String logoutButtonLabel;
  final String operationSuccess;
  final String operationError;

  UiLabels({
    required this.menuItemHome,
    required this.menuItemSettings,
    required this.tittleLoginForm,
    required this.inputUserLabel,
    required this.inputPasswordLabel,
    required this.loginButtonLabel,
    required this.welcomeMessage,
    required this.logoutButtonLabel,
    required this.operationSuccess,
    required this.operationError,
  });

  factory UiLabels.fromJson(Map<String, dynamic> json) {
    return UiLabels(
      menuItemHome: json['menuItemHome'] ?? 'Home',
      menuItemSettings: json['menuItemSettings'] ?? 'Settings',
      tittleLoginForm: json['tittleLoginForm'] ?? 'Log in to your account',
      inputUserLabel: json['inputUserLabel'] ?? 'User',
      inputPasswordLabel: json['inputPasswordLabel'] ?? 'Password',
      loginButtonLabel: json['loginButtonLabel'] ?? 'Login',
      welcomeMessage: json['welcomeMessage'] ?? 'Welcome',
      logoutButtonLabel: json['logoutButtonLabel'] ?? 'Logout',
      operationSuccess: json['operationSuccess'] ?? "Operation Successful!",
      operationError: json['operationError'] ?? "Something went wrong!",
    );
  }
}
