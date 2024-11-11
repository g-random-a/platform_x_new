class CustomAppErrorMessage {
  final String message;
  final String code;

  const CustomAppErrorMessage({required this.message, required this.code});
}


class HiveErrors {
  static const CustomAppErrorMessage openBoxFailed = CustomAppErrorMessage(
    message: 'Failed to open box',
    code: 'hbo_001',
    );
  static const CustomAppErrorMessage readFromBoxFailed = CustomAppErrorMessage(
    message: 'Failed to read from box',
    code: 'hbr_001',
  );
  static const CustomAppErrorMessage writeToBoxFailed = CustomAppErrorMessage(
    message: 'Failed to write to box',
    code: 'hbw_001'
  );
  
}