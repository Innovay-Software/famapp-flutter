import 'package:flutter/material.dart';

import '../views/app_bar.dart';

class InnoPageLoadingScaffoldWidget extends StatelessWidget {
  final String title;
  const InnoPageLoadingScaffoldWidget({super.key, this.title = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: InnoAppBar(true, title, []));
  }
}
