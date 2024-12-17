import 'package:famapp/features/livechat/viewmodel/datasources/im_local_realm_datasource.dart';

import 'services/inno_local_database_service.dart';
import 'services/inno_secure_storage_service.dart';
import 'utils/debug_utils.dart';

class InnoInitService {
  static Future<bool> appInitialization() async {
    await InnoSecureStorageService.asyncConstructor();
    await InnoLocalDatabaseService.init();
    // await ImLocalDatasourceSQLite.init();
    await ImLocalDatasourceRealm.init();

    DebugManager.log("InnoInitService.appInitialization succeeded");
    return true;
  }
}
