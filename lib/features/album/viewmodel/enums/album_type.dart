import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum AlbumType {
  normal,
  baby,
}

extension FolderTypeExtension on AlbumType {
  String toShortString() {
    return toString().split('.').last;
  }

  String toTranslatedString(BuildContext context) {
    switch (this) {
      case AlbumType.normal:
        return AppLocalizations.of(context)!.albumTypeNormal;
      case AlbumType.baby:
        return AppLocalizations.of(context)!.albumTypeBaby;
        return '儿童相册';
    }
  }
}
