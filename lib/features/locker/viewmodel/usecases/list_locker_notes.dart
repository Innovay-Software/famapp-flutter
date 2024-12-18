import '../../../../core/utils/api_utils.dart';
import '../../model/locker_note_model.dart';
import '../datasources/locker_notes_remote_datasource.dart';

class ListLockerNotes {
  Future<ApiResponse> call({required List<LockerNote> lockerNotes}) async {
    final remoteDatasource = LockerNotesRemoteDatasource();
    final response = await remoteDatasource.listLockerNotes();
    if (!response.successful) {
      return response;
    }
    lockerNotes.clear();
    for (var item in response.data['notes']) {
      lockerNotes.add(LockerNote.fromJson(item));
    }
    return response;
  }
}
