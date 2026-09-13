class TriviaException implements Exception {
  final String message;
  final Object? cause;

  TriviaException(this.message, [this.cause]);

  @override
  String toString() {
    if (cause != null) return 'TriviaException: $message (Underlying: $cause)';
    return 'TriviaException: $message';
  }
}
