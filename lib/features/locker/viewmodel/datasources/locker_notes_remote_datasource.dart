import '../../../../core/config.dart';
import '../../../../core/utils/network_utils.dart';
import '../../model/locker_note_model.dart';
import '../usecases/params/delete_locker_note_params.dart';
import '../usecases/params/get_locker_notes_params.dart';
import '../usecases/params/save_locker_note_params.dart';

class LockerNotesRemoteDatasource {
  Future<List<LockerNote>> getLockerNotes({required GetLockerNotesParams params}) async {
    var url = InnoConfig.mainNetworkConfig.getLockerNotes(params.page, params.pageSize);
    var res = await NetworkManager.postRequestSync(url);
    var notes = <LockerNote>[];
    for (var item in res['data']['notes']) {
      notes.add(LockerNote.fromJson(item));
    }
    return notes;
  }

  Future<LockerNote> saveLockerNote({required SaveLockerNoteParams params}) async {
    var url = InnoConfig.mainNetworkConfig.saveLockerNote(params.model.id);
    var res = await NetworkManager.postRequestSync(url, dataLoad: params.toMap());
    var note = LockerNote.fromJson(res['data']['note']);
    return note;
  }

  Future<void> deleteLockerNote({required DeleteLockerNoteParams params}) async {
    var url = InnoConfig.mainNetworkConfig.deleteLockerNote(params.model.id);
    var res = await NetworkManager.postRequestSync(url);
  }
}
