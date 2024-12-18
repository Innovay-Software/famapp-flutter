class ApiResponse {
  final bool successful;
  final String requester;
  final DateTime responseTime;
  final String errorMessage;
  final String accessToken;
  final String refreshToken;
  final Map<String, dynamic> data;
  ApiResponse._(
    this.successful,
    this.requester,
    this.responseTime,
    this.errorMessage,
    this.accessToken,
    this.refreshToken,
    this.data,
  );

  factory ApiResponse.fromMap(bool successful, Map<String, dynamic> map) {
    return ApiResponse._(
      successful,
      map['requester'] ?? 'Unknown',
      DateTime.tryParse('${map['responseDateTime']}') ?? DateTime.now(),
      map['errorMessage'] ?? '',
      map['accessToken'] ?? '',
      map['refreshToken'] ?? '',
      map['data'] ?? {},
    );
  }
}
