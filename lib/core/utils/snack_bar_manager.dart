class SnackBarManager {
  static late Function(String, int) overlayDisplayMessage;

  static void displayMessage(String content, {int seconds = 2}) {
    overlayDisplayMessage(content, seconds);
  }

  static void displayPermissionDeniedMessage() {
    return displayMessage('Permission Denied');
  }

  static void displayAllFilesUploadedMessage() {
    return displayMessage('All files uploaded');
  }
}
