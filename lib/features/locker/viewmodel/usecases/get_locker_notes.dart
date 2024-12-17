import 'package:either_dart/either.dart';

import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../../model/locker_note_model.dart';
import '../datasources/locker_notes_remote_datasource.dart';
import 'params/get_locker_notes_params.dart';

class GetLockerNotes {
  Future<Either<DataFetchError, List<LockerNote>>> call({required GetLockerNotesParams params}) async {
    try {
      final remoteDatasource = LockerNotesRemoteDatasource();
      final response = await remoteDatasource.getLockerNotes(params: params);
      return Right(response);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
