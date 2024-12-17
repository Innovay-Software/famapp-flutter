import 'dart:convert';

import 'package:either_dart/either.dart';

import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/services/inno_secure_storage_service.dart';
import '../../../../enums/enums.dart';
import '../../model/used_account.dart';

class SaveUsedAccounts {
  Future<Either<DataFetchError, bool>> call({
    required List<UsedAccount> usedAccounts,
  }) async {
    try {
      var json = [];
      for (var item in usedAccounts) {
        json.add(item.toJson());
      }
      InnoSecureStorageService().setStaticStorageValue(
        InnoSecureStorageKeys.usedUserAccounts,
        jsonEncode(json),
      );
      return const Right(true);
    } catch (e) {}
    return const Right(false);
  }
}
