import '../../../../../core/abstracts/inno_params.dart';
import '../../../model/locker_note_model.dart';

class SaveLockerNoteParams extends InnoParams {
  final LockerNote model;

  SaveLockerNoteParams({required this.model});

  @override
  Map<String, dynamic> toMap() {
    return model.toJson();
  }
}
