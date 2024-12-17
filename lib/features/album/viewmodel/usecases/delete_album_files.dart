import 'package:either_dart/either.dart';

import '../../../../core/config.dart';
import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../../model/album.dart';

class DeleteAlbumFiles {
  Future<Either<DataFetchError, bool>> call({
    required Album album,
    required List<int> deleteFileIds,
  }) async {
    try {
      final response = await NetworkManager.postRequestSync(
        InnoConfig.mainNetworkConfig.deleteFiles(album.id),
        dataLoad: {'fileIds': deleteFileIds},
      );

      for (var i = 0; i < album.files.length; i++) {
        if (deleteFileIds.isEmpty) {
          break;
        }

        if (deleteFileIds.contains(album.files[i].id)) {
          deleteFileIds.remove(album.files[i].id);
          album.files.removeAt(i);
          i -= 1;
        }
      }

      album.saveLocalCache();
      return const Right(true);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
