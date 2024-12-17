import 'package:either_dart/either.dart';

import '../../../../core/config.dart';
import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../../model/album_file.dart';

class SaveAlbumFile {
  Future<Either<DataFetchError, bool>> call({required AlbumFile albumFile}) async {
    try {
      final postData = {'remark': albumFile.remark, 'isPrivate': albumFile.isPrivate};
      final response = await NetworkManager.postRequestSync(
        InnoConfig.mainNetworkConfig.saveAlbumFile(albumFile.id),
        dataLoad: postData,
      );
      return const Right(true);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
