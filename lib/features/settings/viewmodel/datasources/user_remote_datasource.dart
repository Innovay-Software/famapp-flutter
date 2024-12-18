import 'package:famapp/api_agent.dart';

import '../../../../core/utils/api_utils.dart';

class UserRemoteDatasource {
  Future<ApiResponse> login({
    required String mobile,
    required String password,
    required String deviceToken,
  }) async {
    return ApiAgent.instance.authMobileLoginEndPoint(
      mobile,
      password,
      deviceToken,
    );
  }

  Future<ApiResponse> loginWithAccessToken({
    required String accessToken,
    required String deviceToken,
  }) async {
    return ApiAgent.instance.authAccessTokenLoginEndPoint(accessToken, deviceToken);
  }

  Future<ApiResponse> updateUserProfile({
    required String? name,
    required String? mobile,
    required String? password,
    required String? lockerPasscode,
    required String? avatar,
  }) async {
    return ApiAgent.instance.userUpdateProfileEndPoint(name, mobile, password, lockerPasscode, avatar);
  }
}
