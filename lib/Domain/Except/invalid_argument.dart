class InvalidArgument implements Exception {
  final String message;

  // Constructor for the exception to accept a message
  InvalidArgument(this.message);

  @override
  String toString() => 'InvalidArgument: $message';
}
