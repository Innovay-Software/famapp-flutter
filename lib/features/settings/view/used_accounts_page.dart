import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/config.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/innovay_text.dart';
import '../../initialization/view/login.dart';
import '../view/widgets/used_account_bar.dart';
import '../viewmodel/used_account_viewmodel.dart';

class UsedAccountsPage extends StatefulWidget {
  const UsedAccountsPage({super.key});

  @override
  State<UsedAccountsPage> createState() => _UsedAccountsPageState();
}

class _UsedAccountsPageState extends State<UsedAccountsPage> {
  final UsedAccountViewmodel _viewmodel = UsedAccountViewmodel();
  bool _showDeleteButton = false;

  @override
  void initState() {
    super.initState();
    _getUsedAccounts();
  }

  void _getUsedAccounts() {
    _viewmodel.getUsedAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InnoAppBar(
        false,
        AppLocalizations.of(context)!.switchAccounts,
        [
          _showDeleteButton
              ? IconButton(
                  icon: Icon(Icons.check_circle_outline, color: InnoConfig.colors.primaryColor),
                  onPressed: _onManageAccountsCompletedTap,
                )
              : IconButton(
                  icon: Icon(CupertinoIcons.delete_simple, color: InnoConfig.colors.deleteColor),
                  onPressed: _onManageAccountsTap,
                )
        ],
      ),
      backgroundColor: InnoConfig.colors.backgroundColorTinted4,
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          // padding: const EdgeInsets.all(0),
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset('assets/icon/icon_1024.png', width: 60, height: 60),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 1,
                  color: InnoConfig.colors.textColorLight10,
                )
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...(context.watch<UsedAccountViewmodel>().usedAccounts.map((item) => UsedAccountBar(
                          usedAccount: item,
                          showDeleteButton: _showDeleteButton,
                        ))),
                    GestureDetector(
                      onTap: _onNewAccountTap,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: InnoConfig.colors.backgroundColor,
                        ),
                        child: Row(
                          children: [
                            Container(
                              color: InnoConfig.colors.backgroundColorTinted4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, size: 44, color: InnoConfig.colors.backgroundColor),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            InnoText(AppLocalizations.of(context)!.loginNewAccount),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onNewAccountTap() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _onManageAccountsTap() {
    setState(() {
      _showDeleteButton = true;
    });
  }

  void _onManageAccountsCompletedTap() {
    setState(() {
      _showDeleteButton = false;
    });
  }
}
