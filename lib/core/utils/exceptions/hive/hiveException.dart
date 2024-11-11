class HiveException implements Exception {
  final String message;
  final int code;

  HiveException(this.message, this.code);

  @override
  String toString() {
    return 'HiveException: $message (Code: $code)';
  }
}

// Example usage:
// throw HiveException('Failed to open box', 1001);
// throw HiveException('Failed to read from box', 1002);
// throw HiveException('Failed to write to box', 1003);