import 'package:famapp/core/utils/api_utils.dart';

import '../datasources/user_remote_datasource.dart';

class UserLoginWithAccessToken {
  Future<ApiResponse> call({
    required String accessToken,
  }) async {
    final datasource = UserRemoteDatasource();
    final response = await datasource.loginWithAccessToken(
      accessToken: accessToken,
      deviceToken: '',
    );
    return response;
  }
}
