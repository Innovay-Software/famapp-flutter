import 'package:famapp/core/utils/api_utils.dart';

import '../datasources/user_remote_datasource.dart';

class UserLogin {
  Future<ApiResponse> call({
    required String mobile,
    required String password,
    required String deviceToken,
  }) async {
    final datasource = UserRemoteDatasource();
    final response = await datasource.login(
      mobile: mobile,
      password: password,
      deviceToken: deviceToken,
    );
    return response;
  }
}
