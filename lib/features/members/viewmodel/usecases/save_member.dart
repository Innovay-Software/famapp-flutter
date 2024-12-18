import 'package:famapp/core/utils/api_utils.dart';

import '../../model/member_model.dart';
import '../datasources/member_remote_datasource.dart';

class SaveMember {
  Future<ApiResponse> call({
    required List<Member> members,
    required Member newMember,
  }) async {
    final remoteDatasource = MemberRemoteDatasource();
    final response = await remoteDatasource.saveMember(
      userId: newMember.id,
      name: newMember.name,
      mobile: newMember.mobile,
      password: newMember.password,
      lockerPasscode: newMember.lockerPasscode,
      role: newMember.role,
      familyId: newMember.familyId,
    );
    if (!response.successful) {
      return response;
    }
    newMember.id = int.tryParse('${response.data["user"]["id"]}') ?? 0;

    // final newMember = Member.fromJson(response.data['user']);
    // Member? targetMember;
    for (var i = 0; i < members.length; i++) {
      if (members[i].id == newMember.id) {
        return response;
      }
    }
    members.add(newMember);
    return response;
  }
}
