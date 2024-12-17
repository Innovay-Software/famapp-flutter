import 'package:either_dart/either.dart';

import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../datasources/member_remote_datasource.dart';
import 'params/save_member_params.dart';

class SaveMember {
  Future<Either<DataFetchError, void>> call({required SaveMemberParams params}) async {
    try {
      final remoteDatasource = MemberRemoteDatasource();
      final response = await remoteDatasource.saveMember(params: params);
      return Right(response);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
