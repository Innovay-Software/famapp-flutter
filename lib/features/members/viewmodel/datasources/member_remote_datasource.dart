import '../../../../api_agent.dart';
import '../../../../core/utils/api_utils.dart';

class MemberRemoteDatasource {
  Future<ApiResponse> listMembers({
    required int afterId,
  }) async {
    return ApiAgent.instance.adminListUsersEndPoint(afterId);
  }

  Future<ApiResponse> saveMember({
    required int userId,
    required String name,
    required String mobile,
    required String password,
    required String lockerPasscode,
    required String role,
    required int familyId,
  }) async {
    return ApiAgent.instance.adminSaveUserEndPoint(
      userId,
      name,
      mobile,
      password,
      lockerPasscode,
      role,
      familyId,
    );
  }

  Future<ApiResponse> deleteMember({required String userUuid}) async {
    return ApiAgent.instance.adminDeleteUserEndPoint(userUuid);
  }
}
