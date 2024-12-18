import 'package:famapp/features/locker/model/locker_note_model.dart';

import '../../../../core/utils/api_utils.dart';
import '../datasources/locker_notes_remote_datasource.dart';

class DeleteLockerNote {
  Future<ApiResponse> call({required List<LockerNote> notes, required int noteId}) async {
    final remoteDatasource = LockerNotesRemoteDatasource();
    final response = await remoteDatasource.deleteLockerNote(noteId: noteId);
    if (!response.successful) {
      return response;
    }

    for (var i = 0; i < notes.length; i++) {
      if (notes[i].id == noteId) {
        notes.removeAt(i);
        break;
      }
    }
    return response;
  }
}
