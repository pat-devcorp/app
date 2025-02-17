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
  final String clientList;
  final String registerClient;
  final String home;
  final String welcomeTo9780Bitcoin;
  final String name;
  final String email;
  final String register;

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
    required this.clientList,
    required this.registerClient,
    required this.home,
    required this.welcomeTo9780Bitcoin,
    required this.name,
    required this.email,
    required this.register,
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
      clientList: json["clientList"] ?? "Client list",
      registerClient: json["registerClient"] ?? "Register client",
      home: json["home"] ?? "home",
      welcomeTo9780Bitcoin: json["welcomeTo9780Bitcoin"] ?? "Welcome to 9780Bitcoin",
      name: json['name'] ?? 'name',
      email: json['email'] ?? 'email',
      register: json['register'] ?? 'register',
    );
  }
}
