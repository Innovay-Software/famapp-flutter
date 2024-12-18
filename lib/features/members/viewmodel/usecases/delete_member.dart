import 'package:famapp/core/utils/api_utils.dart';
import 'package:famapp/features/members/model/member_model.dart';
import '../datasources/member_remote_datasource.dart';

class DeleteMember {
  Future<ApiResponse> call({
    required List<Member> members,
    required String userUuid,
  }) async {
    final remoteDatasource = MemberRemoteDatasource();
    final response = await remoteDatasource.deleteMember(userUuid: userUuid);
    if (!response.successful) {
      return response;
    }
    for (var i = 0; i < members.length; i++) {
      if (members[i].uuid == userUuid) {
        members.removeAt(i);
        break;
      }
    }
    return response;
  }
}
