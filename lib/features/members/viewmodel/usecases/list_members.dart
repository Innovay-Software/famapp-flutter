import 'package:famapp/core/utils/api_utils.dart';
import '../../model/member_model.dart';
import '../datasources/member_remote_datasource.dart';

class ListMembers {
  Future<ApiResponse> call({
    required List<Member> members,
    required int afterId,
  }) async {
    final remoteDatasource = MemberRemoteDatasource();
    final response = await remoteDatasource.listMembers(afterId: afterId);
    if (!response.successful) {
      return response;
    }
    if (afterId <= 0) {
      members.clear();
    }
    final membersRaw = response.data['members'];
    for (var i = 0; i < membersRaw.length; i++) {
      members.add(Member.fromJson(membersRaw[i]));
    }

    return response;
  }
}
