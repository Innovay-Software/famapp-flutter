import '../../../../../core/abstracts/inno_params.dart';
import '../../../model/member_model.dart';

class SaveMemberParams extends InnoParams {
  final Member model;

  SaveMemberParams({required this.model});

  @override
  Map<String, dynamic> toMap() {
    return model.toJson();
  }
}
