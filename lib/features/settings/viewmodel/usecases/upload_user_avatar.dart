import 'package:either_dart/either.dart';

import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/models/inno_file_upload_item.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../../model/uploaded_file.dart';
import '../../model/user.dart';

class UploadUserAvatar {
  Future<Either<DataFetchError, UploadedFile>> call({
    required User user,
    required InnoFileUploadItem uploadItem,
    required Function(InnoFileUploadItem?) progressCallback,
  }) async {
    try {
      progressCallback(uploadItem);
      var uploadedFile = await uploadItem.uploadToCloudSync(
        useChunkUpload: true,
        progressCallback: (progress) {
          progressCallback(uploadItem);
        },
      );
      return Right(uploadedFile);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
