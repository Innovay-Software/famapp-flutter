import 'package:either_dart/either.dart';

import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../../model/locker_note_model.dart';
import '../datasources/locker_notes_remote_datasource.dart';
import 'params/save_locker_note_params.dart';

class SaveLockerNote {
  Future<Either<DataFetchError, LockerNote>> call({required SaveLockerNoteParams params}) async {
    try {
      final remoteDatasource = LockerNotesRemoteDatasource();
      final response = await remoteDatasource.saveLockerNote(params: params);
      return Right(response);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
