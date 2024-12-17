import 'package:either_dart/either.dart';

import '../../../../core/config.dart';
import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import 'params/save_user_settings_params.dart';

class SaveUserProfile {
  Future<Either<DataFetchError, Map>> call({
    required SaveUserSettingsParams params,
  }) async {
    try {
      var result = await NetworkManager.postRequestSync(
        InnoConfig.mainNetworkConfig.updateUserProfile(),
        dataLoad: params.toMap(),
      );

      return Right(result);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
