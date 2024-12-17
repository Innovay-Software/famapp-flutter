import '../../../../../core/abstracts/inno_params.dart';
import '../../../model/member_model.dart';

class DeleteMemberParams extends InnoParams {
  final Member model;

  DeleteMemberParams({required this.model});

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}
