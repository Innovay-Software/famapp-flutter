import '../../../../api_agent.dart';
import '../../../../core/utils/api_utils.dart';

class LockerNotesRemoteDatasource {
  Future<ApiResponse> listLockerNotes() {
    return ApiAgent.instance.lockerNoteListEndPoint();
  }

  Future<ApiResponse> deleteLockerNote({
    required int noteId,
  }) {
    return ApiAgent.instance.lockerNoteDeleteEndPoint(noteId);
  }

  Future<ApiResponse> saveLockerNote({
    required int noteId,
    required String title,
    required String content,
    required List<int> invitees,
  }) {
    return ApiAgent.instance.lockerNoteSaveEndPoint(noteId, title, content, invitees);
  }

  // Future<List<LockerNote>> getLockerNotes({required GetLockerNotesParams params}) async {
  //   var url = InnoConfig.mainNetworkConfig.getLockerNotes(params.page, params.pageSize);
  //   var res = await NetworkManager.postRequestSync(url);
  //   var notes = <LockerNote>[];
  //   for (var item in res['data']['notes']) {
  //     notes.add(LockerNote.fromJson(item));
  //   }
  //   return notes;
  // }
  //
  // Future<LockerNote> saveLockerNote({required SaveLockerNoteParams params}) async {
  //   var url = InnoConfig.mainNetworkConfig.saveLockerNote(params.model.id);
  //   var res = await NetworkManager.postRequestSync(url, dataLoad: params.toMap());
  //   var note = LockerNote.fromJson(res['data']['note']);
  //   return note;
  // }
  //
  // Future<void> deleteLockerNote({required DeleteLockerNoteParams params}) async {
  //   var url = InnoConfig.mainNetworkConfig.deleteLockerNote(params.model.id);
  //   var res = await NetworkManager.postRequestSync(url);
  // }
}
