import '../../../../core/utils/api_utils.dart';
import '../datasources/locker_notes_remote_datasource.dart';

class SaveLockerNote {
  Future<ApiResponse> call({
    required int noteId,
    required String title,
    required String content,
    required List<int> invitees,
  }) async {
    final remoteDatasource = LockerNotesRemoteDatasource();
    final response = await remoteDatasource.saveLockerNote(
      noteId: noteId,
      title: title,
      content: content,
      invitees: invitees,
    );
    return response;
  }
}
