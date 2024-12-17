import '../../../../core/config.dart';
import '../../../../core/global_data.dart';
import '../../../../core/utils/network_utils.dart';

class UserRemoteDatasource {
  Future<Map<String, dynamic>> login({required String mobile, required String password}) async {
    var res = await NetworkManager.postRequestSync(
      InnoConfig.mainNetworkConfig.login(),
      dataLoad: {
        'mobile': mobile,
        'password': password,
        'deviceToken': InnoGlobalData.deviceToken,
      },
    );
    return res;
  }

  Future<Map<String, dynamic>> loginWithAccessToken({required String accessToken}) async {
    var res = await NetworkManager.postRequestSync(
      InnoConfig.mainNetworkConfig.accessTokenLogin(),
      dataLoad: {'deviceToken': InnoGlobalData.deviceToken},
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    return res;
  }
}
