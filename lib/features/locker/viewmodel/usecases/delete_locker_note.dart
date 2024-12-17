import 'package:either_dart/either.dart';

import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../datasources/locker_notes_remote_datasource.dart';
import '../usecases/params/delete_locker_note_params.dart';

class DeleteLockerNote {
  Future<Either<DataFetchError, void>> call({required DeleteLockerNoteParams params}) async {
    try {
      final remoteDatasource = LockerNotesRemoteDatasource();
      final response = await remoteDatasource.deleteLockerNote(params: params);
      return Right(response);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
