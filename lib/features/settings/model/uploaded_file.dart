class UploadedFile {
  int id;
  int userId;
  String fileUrl;
  String fileName;
  String fileType;
  String filePath;
  DateTime createdAt;
  DateTime updatedAt;

  UploadedFile({
    required this.id,
    required this.userId,
    required this.fileUrl,
    required this.fileName,
    required this.fileType,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UploadedFile.fromJson(Map<String, dynamic> json) {
    return UploadedFile(
      id: int.tryParse('${json['id']}') ?? 0,
      userId: int.tryParse('${json['userId']}') ?? 0,
      fileUrl: '${json['fileUrl'] ?? ''}',
      fileName: '${json['fileName'] ?? ''}',
      fileType: '${json['fileType'] ?? ''}',
      filePath: '${json['filePath'] ?? ''}',
      createdAt: DateTime.tryParse('${json['createdAt'] ?? ''}') ?? DateTime.now(),
      updatedAt: DateTime.tryParse('${json['createdAt'] ?? ''}') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'fileName': fileName,
      'fileType': fileType,
      'filePath': filePath,
    };
  }
}
