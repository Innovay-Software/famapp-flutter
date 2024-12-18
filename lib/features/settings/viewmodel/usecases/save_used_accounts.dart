import 'dart:convert';

import '../../../../core/services/inno_secure_storage_service.dart';
import '../../../../enums/enums.dart';
import '../../model/used_account.dart';

class SaveUsedAccounts {
  Future<bool> call({
    required List<UsedAccount> usedAccounts,
  }) async {
    var json = [];
    for (var item in usedAccounts) {
      json.add(item.toJson());
    }
    InnoSecureStorageService().setStaticStorageValue(
      InnoSecureStorageKeys.usedUserAccounts,
      jsonEncode(json),
    );
    return true;
  }
}
