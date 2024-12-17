import '../../../core/abstracts/inno_viewmodel.dart';
import '../model/locker_note_model.dart';
import 'usecases/delete_locker_note.dart';
import 'usecases/get_locker_notes.dart';
import 'usecases/params/delete_locker_note_params.dart';
import 'usecases/params/get_locker_notes_params.dart';
import 'usecases/params/save_locker_note_params.dart';
import 'usecases/save_locker_note.dart';

class LockerViewmodel extends InnoViewmodel {
  static final LockerViewmodel _instance = LockerViewmodel._internal();
  factory LockerViewmodel() => _instance;
  LockerViewmodel._internal();

  final List<LockerNote> _lockerNotes = [];
  List<LockerNote> get lockerNotes => _lockerNotes;

  Future<bool> getLockerNotes({required int page, required int pageSize}) async {
    final useCase = GetLockerNotes();
    final response = await useCase.call(
      params: GetLockerNotesParams(page: page, pageSize: pageSize),
    );
    if (!validateUseCaseResponse(response)) {
      return false;
    }
    if (page == 1) {
      _lockerNotes.clear();
    }
    _lockerNotes.addAll(response.right);
    notifyListeners();
    return true;
  }

  Future<bool> saveLockerNote({required LockerNote lockerNote}) async {
    final userCase = SaveLockerNote();
    final response = await userCase.call(
      params: SaveLockerNoteParams(model: lockerNote),
    );
    if (!validateUseCaseResponse(response)) {
      return false;
    }
    var newLockerNote = response.right;
    lockerNote.id = newLockerNote.id;
    notifyListeners();
    return true;
  }

  Future<bool> deleteLockerNote({required LockerNote lockerNote}) async {
    final userCase = DeleteLockerNote();
    final response = await userCase.call(
      params: DeleteLockerNoteParams(model: lockerNote),
    );
    if (!validateUseCaseResponse(response)) {
      return false;
    }
    for (var i = 0; i < _lockerNotes.length; i++) {
      if (_lockerNotes[i].id == lockerNote.id) {
        _lockerNotes.removeAt(i);
        break;
      }
    }
    notifyListeners();
    return true;
  }
}
