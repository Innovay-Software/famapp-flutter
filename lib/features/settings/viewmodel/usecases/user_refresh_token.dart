import 'package:either_dart/either.dart';

import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../datasources/user_remote_datasource.dart';

class UserLoginWithAccessToken {
  Future<Either<DataFetchError, Map<String, dynamic>>> call({
    required String accessToken,
  }) async {
    try {
      final datasource = UserRemoteDatasource();
      final res = await datasource.loginWithAccessToken(accessToken: accessToken);
      return Right(res);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
