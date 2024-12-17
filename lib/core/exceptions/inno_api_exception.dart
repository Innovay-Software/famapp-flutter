class InnoApiException implements Exception {
  String url;
  String error;
  InnoApiException(this.url, this.error);

  String errorMessage() {
    return error;
  }

  String fullErrorMessage() {
    return ("Invalid API call: $url ($error)");
  }
}
