import 'package:flutter_dotenv/flutter_dotenv.dart';

enum DotEnvField {
  APP_NAME,
  DOMAIN_CA,
  DOMAIN_REMOTE,
  API_VERSION,
  LOG_NETWORK_RESPONSES,
  LIVECHAT_GRPC_SERVER,
  LIVECHAT_GRPC_PORT,
}

extension DotEnvFieldExtension on DotEnvField {
  String toShortString() {
    return toString().split('.').last;
  }

  String getDotEnvString(String fallback) {
    return dotenv.get(toShortString(), fallback: fallback);
  }

  bool getDotEnvBool(bool fallback) {
    return dotenv.getBool(toShortString(), fallback: fallback);
  }

  int getDotEnvInt(int fallback) {
    return dotenv.getInt(toShortString(), fallback: fallback);
  }
}

class DotEnvManager {
  static Future<void> loadDotEnv(List<String> filePaths) async {
    for (final item in filePaths) {
      await dotenv.load(fileName: item);
    }
    for (final field in DotEnvField.values) {
      if (dotenv.maybeGet(field.toShortString()) == null) {
        throw Exception("Required dotenv field missing: ${field.toShortString()}");
      }
    }
  }
}
