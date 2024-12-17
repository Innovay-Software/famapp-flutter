import 'package:either_dart/either.dart';

import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../../model/member_model.dart';
import '../datasources/member_remote_datasource.dart';
import 'params/get_members_params.dart';

class GetMembers {
  Future<Either<DataFetchError, List<Member>>> call({required GetMembersParams params}) async {
    try {
      final remoteDatasource = MemberRemoteDatasource();
      final response = await remoteDatasource.getMembers(params: params);
      return Right(response);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
