import 'package:either_dart/either.dart';

import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../datasources/member_remote_datasource.dart';
import 'params/delete_member_params.dart';

class DeleteMember {
  Future<Either<DataFetchError, void>> call({required DeleteMemberParams params}) async {
    try {
      final remoteDatasource = MemberRemoteDatasource();
      final response = await remoteDatasource.deleteMember(params: params);
      return Right(response);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
