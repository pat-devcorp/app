class UiLabels {
  final String menuItemHome;
  final String menuItemSettings;
  final String welcomeMessage;
  final String logoutButtonLabel;
  final String operationSuccess;
  final String operationError;

  final LoginLabels loginLabels;

  UiLabels({
    required this.menuItemHome,
    required this.menuItemSettings,
    required this.welcomeMessage,
    required this.logoutButtonLabel,
    required this.operationSuccess,
    required this.operationError,
    required this.loginLabels,
  });

  factory UiLabels.fromJson(Map<String, dynamic> json) {
    return UiLabels(
      menuItemHome: json['menuItemHome'] ?? 'Home',
      menuItemSettings: json['menuItemSettings'] ?? 'Settings',
      welcomeMessage: json['welcomeMessage'] ?? 'Welcome',
      logoutButtonLabel: json['logoutButtonLabel'] ?? 'Logout',
      operationSuccess: json['operationSuccess'] ?? "Operation Successful!",
      operationError: json['operationError'] ?? "Something went wrong!",
      loginLabels: LoginLabels.fromJson(json['loginPage'] ?? {}),
    );
  }
}

class LoginLabels {
  final String tittle;
  final String inputUserLabel;
  final String inputPasswordLabel;
  final String loginButtonLabel;

  LoginLabels({
    required this.tittle,
    required this.inputUserLabel,
    required this.inputPasswordLabel,
    required this.loginButtonLabel,
  });
  factory LoginLabels.fromJson(Map<String, dynamic> json) {
    return LoginLabels(
      tittle: json['tittle'] ?? 'Log in to your account',
      inputUserLabel: json['inputUserLabel'] ?? 'User',
      inputPasswordLabel: json['inputPasswordLabel'] ?? 'Password',
      loginButtonLabel: json['loginButtonLabel'] ?? 'Login',
    );
  }
}
