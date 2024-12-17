enum Language { chinese, english }

extension LanguageExtension on Language {
  String toShortString() {
    return toString().split('.').last;
  }
}

enum BackendServerType { regionCA, regionRemote, regionClosest }

extension BackendServerTypeExtension on BackendServerType {
  String toShortString() {
    return toString().split('.').last;
  }
}

enum InnoSecureStorageKeys {
  defaultMediaSource,
  lastActiveAlbumId,
  lastLoggedInUserId,
  preferredBackendServer,
  usedUserAccounts,
  userLanguage,
}

extension InnoSecureStorageKeysExtension on InnoSecureStorageKeys {
  String toShortString() {
    return toString().split('.').last;
  }

  List<String> allShortStrings() {
    var result = <String>[];
    for (var item in InnoSecureStorageKeys.values) {
      result.add(item.toShortString());
    }
    return result;
  }
}
