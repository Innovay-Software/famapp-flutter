import '../../../core/abstracts/inno_viewmodel.dart';
import '../model/locker_note_model.dart';
import 'usecases/delete_locker_note.dart';
import 'usecases/list_locker_notes.dart';
import 'usecases/save_locker_note.dart';

class LockerViewmodel extends InnoViewmodel {
  static final LockerViewmodel _instance = LockerViewmodel._internal();
  factory LockerViewmodel() => _instance;
  LockerViewmodel._internal();

  final List<LockerNote> _lockerNotes = [];
  List<LockerNote> get lockerNotes => _lockerNotes;

  Future<bool> getLockerNotes({required int page, required int pageSize}) async {
    final useCase = ListLockerNotes();
    final response = await useCase.call(lockerNotes: _lockerNotes);
    if (!validateUseCaseResponse2(response)) {
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> saveLockerNote({required LockerNote lockerNote}) async {
    final userCase = SaveLockerNote();
    final response = await userCase.call(
      noteId: lockerNote.id,
      title: lockerNote.title,
      content: lockerNote.content,
      invitees: lockerNote.inviteeIds,
    );
    if (!validateUseCaseResponse2(response)) {
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> deleteLockerNote({required LockerNote lockerNote}) async {
    final userCase = DeleteLockerNote();
    final response = await userCase.call(
      notes: _lockerNotes,
      noteId: lockerNote.id,
    );
    if (!validateUseCaseResponse2(response)) {
      return false;
    }
    notifyListeners();
    return true;
  }
}
