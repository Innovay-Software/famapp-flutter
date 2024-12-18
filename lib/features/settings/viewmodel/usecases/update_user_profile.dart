import 'package:famapp/core/utils/api_utils.dart';

import '../datasources/user_remote_datasource.dart';

class UpdateUserProfile {
  Future<ApiResponse> call({
    required String? name,
    required String? mobile,
    required String? password,
    required String? lockerPasscode,
    required String? avatar,
  }) async {
    final datasource = UserRemoteDatasource();
    final response = await datasource.updateUserProfile(
      name: name,
      mobile: mobile,
      password: password,
      lockerPasscode: lockerPasscode,
      avatar: avatar,
    );

    if (!response.successful) {
      return response;
    }
    return response;
  }
}
