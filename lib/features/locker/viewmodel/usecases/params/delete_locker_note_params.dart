import '../../../../../core/abstracts/inno_params.dart';
import '../../../model/locker_note_model.dart';

class DeleteLockerNoteParams extends InnoParams {
  final LockerNote model;

  DeleteLockerNoteParams({required this.model});

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}
