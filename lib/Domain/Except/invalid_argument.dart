class InvalidArgument implements Exception {
  final String message;

  InvalidArgument(this.message);

  @override
  String toString() => 'InvalidArgument: $message';
}
