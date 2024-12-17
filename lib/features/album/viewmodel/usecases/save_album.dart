import 'package:either_dart/either.dart';

import '../../../../core/config.dart';
import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/debug_utils.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../../model/album.dart';

class SaveAlbum {
  Future<Either<DataFetchError, bool>> call({required Album album}) async {
    try {
      final albumData = album.toMap();
      final response = await NetworkManager.postRequestSync(
        InnoConfig.mainNetworkConfig.saveAlbum(album.id),
        dataLoad: albumData,
      );
      DebugManager.log(response);
      album.syncFromRawData(response['data']['folder']);
      return const Right(true);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
