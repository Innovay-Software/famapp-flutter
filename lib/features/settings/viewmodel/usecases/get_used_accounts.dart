import 'dart:convert';

import 'package:either_dart/either.dart';

import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/services/inno_secure_storage_service.dart';
import '../../../../enums/enums.dart';
import '../../model/used_account.dart';

class GetUsedAccounts {
  Future<Either<DataFetchError, List<UsedAccount>>> call() async {
    final usedAccounts = <UsedAccount>[];
    try {
      final value = InnoSecureStorageService().getStaticStorageValue(InnoSecureStorageKeys.usedUserAccounts);
      for (var item in jsonDecode(value)) {
        usedAccounts.add(UsedAccount.fromJson(item));
      }
    } catch (e) {}
    return Right(usedAccounts);
  }
}
