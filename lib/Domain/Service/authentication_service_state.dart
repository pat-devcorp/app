enum AuthenticationServiceState {
  invalidArguments("Invalid Arguments"),
  invalidCredentials("Invalid Credentials"),
  serverError("Server error"),
  notCatch("Error Not Defined"),
  success("1");

  final String value;

  const AuthenticationServiceState(this.value);
}
