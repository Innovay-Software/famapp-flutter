import 'dart:convert';

import '../../../../core/services/inno_secure_storage_service.dart';
import '../../../../enums/enums.dart';
import '../../model/used_account.dart';

class GetUsedAccounts {
  Future<List<UsedAccount>> call() async {
    final usedAccounts = <UsedAccount>[];
    final value = InnoSecureStorageService().getStaticStorageValue(InnoSecureStorageKeys.usedUserAccounts);
    for (var item in jsonDecode(value)) {
      usedAccounts.add(UsedAccount.fromJson(item));
    }
    return usedAccounts;
  }
}
