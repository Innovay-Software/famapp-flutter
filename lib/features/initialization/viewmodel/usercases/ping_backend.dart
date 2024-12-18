import 'package:famapp/api_agent.dart';
import 'package:famapp/core/utils/api_utils.dart';

import '../../../../core/utils/dot_env_manager.dart';

class PingBackend {
  Future<ApiResponse> call(bool pingCaBackend) async {
    final basePath =
        pingCaBackend ? DotEnvField.DOMAIN_CA.getDotEnvString('') : DotEnvField.DOMAIN_REMOTE.getDotEnvString('');

    final apiClient = ApiAgent.init(basePath, (a, b) => null);

    var startTime = DateTime.now().microsecondsSinceEpoch;
    final response = await apiClient.utilPingEndPoint();
    if (!response.successful) {
      response.data['latency'] = -1;
    }
    response.data['latency'] = DateTime.now().microsecondsSinceEpoch - startTime;
    return response;
  }
}
