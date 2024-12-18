import '../../../../api_agent.dart';
import '../../../../core/utils/api_utils.dart';

class InitializationRemoteDatasource {
  Future<ApiResponse> pingBackend() async {
    return ApiAgent.instance.utilPingEndPoint();
  }

  Future<ApiResponse> checkForUpdate({
    required String currentOS,
    required String currentVersion,
  }) async {
    return ApiAgent.instance.utilCheckForMobileUpdateEndPoint(
      currentOS,
      currentVersion,
    );
  }
}
