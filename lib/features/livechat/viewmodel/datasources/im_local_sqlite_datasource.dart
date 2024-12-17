// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../../../../core/global_data.dart';
// import '../../../../core/utils/debug_utils.dart';
// import '../../model/livechat_message.dart';
//
// class ImLocalDatasourceSQLite {
//   late Database imDatabase;
//   String _databaseFilePath = '';
//
//   ImLocalDatasourceSQLite._();
//   static ImLocalDatasourceSQLite? _instance;
//   static ImLocalDatasourceSQLite get instance {
//     if (_instance == null) {
//       throw Exception("ImLocalDatasource has not been properly initialized, "
//           "please call await ImLocalDatasource.init in main");
//     }
//     return _instance!;
//   }
//
//   static Future<ImLocalDatasourceSQLite> init() async {
//     if (_instance != null) {
//       return _instance!;
//     }
//
//     _instance = ImLocalDatasourceSQLite._();
//     var postFix = InnoGlobalData.useRegionCN ? 'cn' : 'ca';
//     postFix = 'ca';
//     _instance!._databaseFilePath = join(await getDatabasesPath(), 'famapp_im.$postFix.db');
//     await _instance!._initDatabaseAndTables();
//     return _instance!;
//   }
//
//   Future<void> _initDatabaseAndTables() async {
//     imDatabase = await openDatabase(
//       _databaseFilePath,
//       onCreate: (db, version) {},
//       version: 1,
//     );
//     DebugManager.log("Database created: $_databaseFilePath");
//     await _createDatabaseTables(imDatabase, 1);
//   }
//
//   Future<void> purgeData() async {
//     // Delete database file
//     await deleteDatabase(_databaseFilePath);
//     // Recreate database file and tables
//     await _initDatabaseAndTables();
//   }
//
//   Future<void> dispose() async {
//     await imDatabase.close();
//   }
//
//   Future<void> _createDatabaseTables(Database db, int version) async {
//     // Create configs table
//     if ((await db.query('sqlite_master', where: "type = 'table' AND name = ?", whereArgs: ['configs'])).isEmpty) {
//       DebugManager.log("Creating configs table");
//       await db.execute('CREATE TABLE configs(id INTEGER PRIMARY KEY, name TEXT, content TEXT)');
//     }
//     DebugManager.log("configs table created");
//
//     // Create imUsersTable
//     if ((await db.query('sqlite_master', where: "type = 'table' AND name = ?", whereArgs: ['im_users'])).isEmpty) {
//       DebugManager.log("Creating im_users table");
//       await db
//           .execute('CREATE TABLE im_users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, mobile TEXT, avatar TEXT)');
//     }
//     DebugManager.log("im_users table created");
//
//     // Create im_messages table
//     if ((await db.query('sqlite_master', where: 'name = ?', whereArgs: ['im_messages'])).isEmpty) {
//       DebugManager.log("Creating im_messages table");
//       await db.execute('CREATE TABLE im_messages('
//           'id INTEGER PRIMARY KEY, im_group_id INTEGER, user_id INTEGER, type TEXT, body TEXT, '
//           'seen INTEGER, created_at INTEGER)');
//     }
//     DebugManager.log("im_messages table created");
//
//     // Create im_group_user table
//     if ((await db.query('sqlite_master', where: 'name = ?', whereArgs: ['im_group_user'])).isEmpty) {
//       DebugManager.log("Creating im_group_user table");
//       await db.execute('CREATE TABLE im_group_user('
//           'id INTEGER PRIMARY KEY, im_group_id INTEGER, user_id INTEGER, unread_count INTEGER)');
//     }
//     DebugManager.log("im_group_user table created");
//
//     // Create im_groups table
//     if ((await db.query('sqlite_master', where: 'name = ?', whereArgs: ['im_groups'])).isEmpty) {
//       DebugManager.log("Creating im_groups table");
//       await db.execute('CREATE TABLE im_groups('
//           'id INTEGER PRIMARY KEY, cloud_group_id TEXT, title TEXT, latest_message TEXT, owner_id INTEGER, '
//           'extra_info TEXT, is_group_chat INTEGER, created_at INTEGER, updated_at INTEGER)');
//     }
//     DebugManager.log("im_groups table created");
//   }
//
//   Future<void> saveImUsers(dynamic imUsersData) async {
//     DebugManager.log("_updateImUsers");
//     for (var item in imUsersData) {
//       DebugManager.log("Update ${item['id']} user");
//       var imUserId = int.tryParse('${item['id']}') ?? 0;
//       if (imUserId <= 0) continue;
//
//       List<Map> records = await imDatabase.query('im_users', where: 'id = ?', whereArgs: [imUserId]);
//       if (records.isEmpty) {
//         await imDatabase.insert('im_users', {
//           'id': imUserId,
//           'name': '${item['name']}',
//           'mobile': '${item['mobile']}',
//           'email': '${item['email']}',
//           'avatar': '${item['avatar']}',
//         });
//       } else {
//         await imDatabase.update(
//             'im_users',
//             {
//               'name': '${item['name']}',
//               'mobile': '${item['mobile']}',
//               'email': '${item['email']}',
//               'avatar': '${item['avatar']}',
//             },
//             where: 'id = ?',
//             whereArgs: [imUserId]);
//       }
//     }
//   }
//
//   Future<void> saveImGroup(int imGroupId, dynamic imGroupData) async {
//     // Check if imGroup is in database
//     List<Map> records = await imDatabase.query('im_groups', where: 'id = ?', whereArgs: [imGroupId]);
//     var createdAt = DateTime.tryParse('${imGroupData['created_at']}') ?? DateTime.now().toUtc();
//     var updatedAt = DateTime.tryParse('${imGroupData['updated_at']}') ?? DateTime.now().toUtc();
//
//     if (records.isEmpty) {
//       DebugManager.log("ImGroup $imGroupId not found, creating a new instance");
//       await imDatabase.insert('im_groups', {
//         'id': imGroupId,
//         'cloud_group_id': '${imGroupData['cloud_group_id']}',
//         'title': '${imGroupData['title']}',
//         'latest_message': '${imGroupData['latest_message']}',
//         'owner_id': int.tryParse('${imGroupData['owner_id']}') ?? 0,
//         'extra_info': '${imGroupData['extra_info']}',
//         'is_group_chat': int.tryParse('${imGroupData['is_group_chat']}') ?? 0,
//         'created_at': (createdAt.millisecondsSinceEpoch / 1000).floor(),
//         'updated_at': (updatedAt.millisecondsSinceEpoch / 1000).floor(),
//       });
//     } else {
//       DebugManager.log("ImGroup $imGroupId found, syncing value");
//       await imDatabase.update(
//           'im_groups',
//           {
//             'cloud_group_id': '${imGroupData['cloud_group_id']}',
//             'title': '${imGroupData['title']}',
//             'latest_message': '${imGroupData['latest_message']}',
//             'owner_id': int.tryParse('${imGroupData['owner_id']}') ?? 0,
//             'extra_info': '${imGroupData['extra_info']}',
//             'is_group_chat': int.tryParse('${imGroupData['is_group_chat']}') ?? 0,
//             'created_at': (createdAt.millisecondsSinceEpoch / 1000).floor(),
//             'updated_at': (updatedAt.millisecondsSinceEpoch / 1000).floor(),
//           },
//           where: 'id = ?',
//           whereArgs: [imGroupId]);
//     }
//   }
//
//   Future<void> saveImGroupUser(int imGroupId, bool isGroupChat, dynamic imGroupUsersData) async {
//     // Update im_group_user s
//     var imGroupUserIds = <int>[];
//     for (var item2 in imGroupUsersData) {
//       var userId = int.tryParse('${item2['user_id']}') ?? 0;
//       imGroupUserIds.add(userId);
//       var unreadCount = int.tryParse('${item2['unread_count']}') ?? 0;
//
//       List<Map> records = await imDatabase.query(
//         'im_group_user',
//         where: 'im_group_id = ? AND user_id = ?',
//         whereArgs: [imGroupId, userId],
//       );
//       if (records.isEmpty) {
//         await imDatabase.insert('im_group_user', {
//           'im_group_id': imGroupId,
//           'user_id': userId,
//           'unread_count': unreadCount,
//         });
//         DebugManager.log("Inserted imGroupUser $imGroupId . $userId");
//       }
//     }
//     if (isGroupChat) {
//       DebugManager.log("Delete from im_group_id $imGroupId AND user id not in ${imGroupUserIds.join(',')}");
//       await imDatabase.delete(
//         'im_group_user',
//         where: 'im_group_id = ? AND user_id NOT IN (${List.filled(imGroupUserIds.length, '?').join(',')})',
//         whereArgs: [imGroupId, ...imGroupUserIds],
//       );
//
//       DebugManager.log("Deleted imGroupUser $imGroupId . ${imGroupUserIds.join(',')}");
//     }
//   }
//
//   Future<int> saveImMessages({
//     required int imGroupId,
//     List<ImMessage> imMessages = const [],
//     dynamic imMessagesData,
//   }) async {
//     // Update im_messages
//     var lastSyncedMessageId = 0;
//     var lastSyncedMessageIdConfigKey = 'imGroup${imGroupId}LastSyncedMessageId';
//     var configRecords = await imDatabase.query('configs', where: 'name = ?', whereArgs: [lastSyncedMessageIdConfigKey]);
//     if (configRecords.isNotEmpty) {
//       lastSyncedMessageId = int.tryParse('${configRecords[0]['content']}') ?? 0;
//     }
//
//     if (imMessages.isNotEmpty) {
//       for (var item in imMessages) {
//         lastSyncedMessageId = await _saveImMessage(imMessage: item, lastSyncedMessageId: lastSyncedMessageId);
//       }
//     } else if (imMessagesData != null) {
//       for (var item in imMessagesData) {
//         lastSyncedMessageId = await _saveImMessage(imMessageData: item, lastSyncedMessageId: lastSyncedMessageId);
//       }
//     }
//
//     if (configRecords.isNotEmpty) {
//       await imDatabase.update('configs', {'content': lastSyncedMessageId},
//           where: 'name = ?', whereArgs: [lastSyncedMessageIdConfigKey]);
//     } else {
//       await imDatabase.insert('configs', {'name': lastSyncedMessageIdConfigKey, 'content': lastSyncedMessageId});
//     }
//
//     return lastSyncedMessageId;
//   }
//
//   Future<int> _saveImMessage({ImMessage? imMessage, dynamic imMessageData, int lastSyncedMessageId = -1}) async {
//     if (lastSyncedMessageId > 0 && imMessage == null && imMessageData == null) {
//       return lastSyncedMessageId;
//     }
//
//     final imMessageId = imMessage != null ? imMessage.id : (int.tryParse('${imMessageData['id']}') ?? 0);
//     if (lastSyncedMessageId > 0 && imMessageId < lastSyncedMessageId) {
//       return lastSyncedMessageId;
//     }
//
//     final int imGroupId =
//         imMessage != null ? imMessage.imGroupId : (int.tryParse('${imMessageData['im_group_id']}') ?? 0);
//     final int userId = imMessage != null ? imMessage.userId : (int.tryParse('${imMessageData['user_id']}') ?? 0);
//     final String messageType = imMessage != null ? imMessage.type.toShortString() : '${imMessageData['type']}';
//     final String messageBody = imMessage != null ? imMessage.body : '${imMessageData['body']}';
//     final int seen = imMessage != null ? (imMessage.seen ? 1 : 0) : (int.tryParse('${imMessageData['seen']}') ?? 0);
//     final int createdAt = ((imMessage != null
//                     ? imMessage.createdAt
//                     : DateTime.tryParse('${imMessageData['created_at']}') ?? DateTime.now().toUtc())
//                 .millisecondsSinceEpoch /
//             1000)
//         .floor();
//
//     List<Map> records = await imDatabase.query('im_messages', where: 'id = ?', whereArgs: [imMessageId]);
//     if (records.isEmpty) {
//       await imDatabase.insert('im_messages', {
//         'id': imMessageId,
//         'im_group_id': imGroupId,
//         'user_id': userId,
//         'type': messageType,
//         'body': messageBody,
//         'seen': seen,
//         'created_at': createdAt,
//       });
//     }
//     return imMessageId;
//   }
//
//   Future<void> clearImMessageUnread(int imGroupId, int lastSeenImMessageId) async {
//     await imDatabase.update(
//         'im_messages',
//         {
//           'seen': 1,
//         },
//         where: 'im_group_id = ? and id <= ?',
//         whereArgs: [imGroupId, lastSeenImMessageId]);
//   }
//
//   Future<List<Map<String, Object?>>> getAllImUsers() async {
//     return await imDatabase.query('im_users', where: 'id > 0');
//   }
//
//   Future<List<Map<String, Object?>>> getAllImGroupsForUser(int userId) async {
//     final imGroupUsers = await imDatabase.query(
//       'im_group_user',
//       where: 'user_id = ?',
//       whereArgs: [userId],
//     );
//     final imGroupIds = <int>[];
//     for (var item in imGroupUsers) {
//       final id = int.tryParse('${item['im_group_id']}') ?? 0;
//       if (id > 0) {
//         imGroupIds.add(id);
//       }
//     }
//
//     return await imDatabase.query(
//       'im_groups',
//       where: 'id IN (${List.filled(imGroupIds.length, '?').join(',')})',
//       whereArgs: imGroupIds,
//       orderBy: 'updated_at DESC',
//     );
//   }
//
//   Future<List<Map<String, Object?>>> getAllImGroupUsers(int imGroupId) async {
//     return await imDatabase.query(
//       'im_group_user',
//       where: 'im_group_id = ?',
//       whereArgs: [imGroupId],
//     );
//   }
//
//   Future<List<Map<String, Object?>>> getImGroupMessagesAfterId(
//       {required int imGroupId, int afterId = 0, int limit = 100}) async {
//     return await imDatabase.query(
//       'im_messages',
//       where: 'im_group_id = ? AND id > ?',
//       whereArgs: [imGroupId, afterId],
//       orderBy: 'id DESC',
//       limit: limit,
//     );
//   }
//
//   Future<List<Map<String, Object?>>> getImGroupMessagesBeforeId(
//       {required int imGroupId, int beforeId = 0, int limit = 100}) async {
//     return await imDatabase.query(
//       'im_messages',
//       where: 'im_group_id = ? AND id < ?',
//       whereArgs: [imGroupId, beforeId],
//       orderBy: 'id DESC',
//       limit: limit,
//     );
//   }
//
//   Future<int> deleteImMessages({required int imGroupId, required List<int> messageIds}) async {
//     return await imDatabase.delete(
//       'im_messages',
//       where: 'im_group_id = ? AND id IN (${List.filled(messageIds.length, '?').join(',')})',
//       whereArgs: [imGroupId, ...messageIds],
//     );
//   }
// }
