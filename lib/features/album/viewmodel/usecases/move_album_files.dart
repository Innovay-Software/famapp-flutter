import 'package:either_dart/either.dart';

import '../../../../core/config.dart';
import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../../model/album.dart';

class MoveAlbumFiles {
  Future<Either<DataFetchError, bool>> call({
    required Album oldAlbum,
    required Album newAlbum,
    required List<int> fileIds,
  }) async {
    try {
      final response = await NetworkManager.postRequestSync(
        InnoConfig.mainNetworkConfig.moveFilesToAlbum(newAlbum.id),
        dataLoad: {'fileIds': fileIds},
      );

      for (var i = 0; i < oldAlbum.files.length; i++) {
        if (fileIds.isEmpty) {
          break;
        }

        if (fileIds.contains(oldAlbum.files[i].id)) {
          fileIds.remove(oldAlbum.files[i].id);
          oldAlbum.files.removeAt(i);
          i -= 1;
        }
      }
      return const Right(true);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
