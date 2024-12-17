import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'innovay_text.dart';

class InnovaySmartRefresherFooter extends StatelessWidget {
  const InnovaySmartRefresherFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = InnoText(AppLocalizations.of(context)!.smartRefresherIdle);
        } else if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = body = InnoText(AppLocalizations.of(context)!.smartRefresherFailed);
        } else if (mode == LoadStatus.canLoading) {
          body = body = InnoText(AppLocalizations.of(context)!.smartRefresherCanLoad);
        } else {
          body = body = InnoText(AppLocalizations.of(context)!.smartRefresherNoMore);
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
