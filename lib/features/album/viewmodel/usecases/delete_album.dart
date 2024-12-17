import 'package:either_dart/either.dart';

import '../../../../core/config.dart';
import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../../model/album.dart';

class DeleteAlbum {
  Future<Either<DataFetchError, bool>> call({required Album album}) async {
    try {
      final response = await NetworkManager.postRequestSync(InnoConfig.mainNetworkConfig.deleteAlbum(album.id));
      return const Right(true);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
