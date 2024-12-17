import 'package:either_dart/either.dart';
import 'package:famapp/core/utils/datetime_util.dart';

import '../../../../core/config.dart';
import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../../core/utils/use_case_exception_handler.dart';

class SetAlbumFilesShotAtDate {
  Future<Either<DataFetchError, bool>> call({required List<int> albumFileIds, required DateTime targetDate}) async {
    try {
      final response = await NetworkManager.postRequestSync(
        InnoConfig.mainNetworkConfig.setShotAtDate(DatetimeUtils.formattedDate(targetDate)),
        dataLoad: {'fileIds': albumFileIds},
      );
      return const Right(true);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
