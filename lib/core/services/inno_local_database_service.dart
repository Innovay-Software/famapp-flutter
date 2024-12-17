import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/debug_utils.dart';

class InnoLocalDatabaseService {
  late Database imDatabase;
  String _databaseFilePath = '';
  // bool _isDatabaseServiceInitialized = false;

  InnoLocalDatabaseService._();
  static InnoLocalDatabaseService? _instance;
  static InnoLocalDatabaseService get instance {
    if (_instance == null) {
      throw Exception("InnoLocalDatabaseService has not been properly initialized, "
          "please call await InnoLocalDatabaseService.init in main");
    }
    return _instance!;
  }

  static Future<InnoLocalDatabaseService> init() async {
    if (_instance != null) {
      return _instance!;
    }

    _instance = InnoLocalDatabaseService._();
    _instance!._databaseFilePath = join(await getDatabasesPath(), 'famapp_inno.ca.db');
    await _instance!._initDatabase();
    return _instance!;
  }

  Future<void> _initDatabase() async {
    imDatabase = await openDatabase(
      _databaseFilePath,
      onCreate: (db, version) {},
      version: 1,
    );
    DebugManager.log("Database created: $_databaseFilePath");
    await _createDatabaseTables(imDatabase, 1);
  }

  // Future<void> purgeDataAndSyncFromCloud() async {
  //   await deleteDatabase(_databaseFilePath);
  //   await _initDatabase();
  //   await syncFromCloud();
  // }

  Future<void> dispose() async {
    await imDatabase.close();
  }

  Future<void> _createDatabaseTables(Database db, int version) async {
    // Create configs table
    if ((await db.query('sqlite_master', where: "type = 'table' AND name = ?", whereArgs: ['configs'])).isEmpty) {
      DebugManager.log("Creating configs table");
      await db.execute('CREATE TABLE configs(id INTEGER PRIMARY KEY, name TEXT, content TEXT)');
    }
    DebugManager.log("configs table created");
  }

  // Future<void> syncFromCloud() async {
  //   DebugManager.log("BabyLocalDatabaseService.syncFromCloud");
  //   try {
  //     // var res = await NetworkManager.postRequestSync(InnoConfig.imNetworkConfig.syncImGroups());
  //     // // DebugManager.log(res.toString());
  //     //
  //     // var imGroupList = res['data']['imGroupList'];
  //     // for (var item in imGroupList) {
  //     //   var imGroupData = item['imGroup'];
  //     //   var imGroupUsersData = item['imGroupUsers'];
  //     //   var imMessagesData = item['imMessages'];
  //     //   var hasMore = int.tryParse('${item['hasMoreMessages']}') ?? 0;
  //     //   var imGroupId = int.tryParse('${imGroupData['id']}') ?? 0;
  //     //   var isGroupChat = int.tryParse('${imGroupData['is_group_chat']}') ?? 0;
  //     //
  //     //   await _updateImGroup(imGroupId, imGroupData);
  //     //   await _updateImGroupUser(imGroupId, isGroupChat == 1, imGroupUsersData);
  //     //   await _updateImMessages(imGroupId, imMessagesData, hasMore);
  //     // }
  //     //
  //     // var imUsers = res['data']['imUsers'];
  //     // await _updateImUsers(imUsers);
  //   } on InnoApiException catch (e) {
  //     // DebugManager.error(e.errorMessage());
  //   } catch (e) {
  //     // DebugManager.error(e.toString());
  //   }
  // }
}
