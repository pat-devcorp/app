enum AuthenticationServiceState {
  invalidArguments("Invalid Arguments"),
  invalidCredentials("Invalid Credentials"),
  serverError("Server error"),
  notCatch("Error Not Defined"),
  success("1");

  final String value;

  const AuthenticationServiceState(this.value);

  static AuthenticationServiceState mapStatusCodeToState(int statusCode) {
    switch (statusCode) {
      case 200:
        return AuthenticationServiceState.success;
      case 400:
        return AuthenticationServiceState.invalidArguments;
      case 401:
        return AuthenticationServiceState.invalidCredentials;
      case 500:
        return AuthenticationServiceState.serverError;
      default:
        return AuthenticationServiceState.notCatch;
    }
  }
}
