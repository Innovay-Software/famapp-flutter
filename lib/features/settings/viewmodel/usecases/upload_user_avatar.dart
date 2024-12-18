import '../../../../core/models/inno_file_upload_item.dart';
import '../../model/uploaded_file.dart';
import '../../model/user.dart';

class UploadUserAvatar {
  Future<UploadedFile> call({
    required User user,
    required InnoFileUploadItem uploadItem,
    required Function(InnoFileUploadItem?) progressCallback,
  }) async {
    progressCallback(uploadItem);
    var uploadedFile = await uploadItem.uploadToCloudSync(
      useChunkUpload: true,
      progressCallback: (progress) {
        progressCallback(uploadItem);
      },
    );
    return uploadedFile;
  }
}
