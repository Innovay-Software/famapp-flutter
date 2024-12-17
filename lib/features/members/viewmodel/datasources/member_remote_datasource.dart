import '../../../../core/config.dart';
import '../../../../core/utils/network_utils.dart';
import '../../model/member_model.dart';
import '../usecases/params/delete_member_params.dart';
import '../usecases/params/get_members_params.dart';
import '../usecases/params/save_member_params.dart';

class MemberRemoteDatasource {
  Future<List<Member>> getMembers({required GetMembersParams params}) async {
    var url = InnoConfig.mainNetworkConfig.adminGetAllMembers(0);
    var res = await NetworkManager.postRequestSync(url);
    var members = <Member>[];
    for (var item in res['data']['users']) {
      members.add(Member.fromJson(item));
    }
    return members;
  }

  Future<void> saveMember({required SaveMemberParams params}) async {
    var url = InnoConfig.mainNetworkConfig.adminSaveMemberInfo(params.model.id);
    var res = await NetworkManager.postRequestSync(url, dataLoad: params.model.toJson());
  }

  Future<void> deleteMember({required DeleteMemberParams params}) async {
    var url = InnoConfig.mainNetworkConfig.adminDeleteMember(params.model.id);
    var res = await NetworkManager.postRequestSync(url);
  }
}
