import 'package:famapp/core/services/inno_secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/config.dart';
import '../../../../core/utils/common_utils.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../../../core/widgets/member_avatar.dart';
import '../../../initialization/view/login.dart';
import '../../model/used_account.dart';
import '../../viewmodel/used_account_viewmodel.dart';
import '../../viewmodel/user_viewmodel.dart';

class UsedAccountBar extends StatelessWidget {
  final UsedAccount usedAccount;
  final bool showDeleteButton;

  const UsedAccountBar({
    super.key,
    required this.usedAccount,
    required this.showDeleteButton,
  });

  @override
  Widget build(BuildContext context) {
    var user = UserViewmodel().currentUser;
    return GestureDetector(
      onTap: () {
        _onTap(context);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: InnoConfig.colors.backgroundColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: MemberAvatarWidget(
                userId: usedAccount.id,
                userName: usedAccount.name,
                userRole: '',
                size: 46,
                showRoleIcon: false,
                clearCache: true,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: InnoText(usedAccount.name, fontSize: 16, color: InnoConfig.colors.textColor)),
                      const SizedBox(width: 15),
                      // if (isCurrentlyLoggedIn && !_showDeleteButton)
                      //   Icon(Icons.check_circle, color: InnovayConfig.colors.successColor),
                    ],
                  ),
                  SizedBox(height: usedAccount.mobile.isNotEmpty ? 8 : 0),
                  if (usedAccount.mobile.isNotEmpty)
                    InnoText(usedAccount.mobile, fontSize: 12, color: InnoConfig.colors.textColorLight7),
                ],
              ),
            ),
            if (showDeleteButton)
              IconButton(
                icon: Icon(
                  Icons.cancel_outlined,
                  color: InnoConfig.colors.deleteColor,
                ),
                onPressed: _onDeleteTap,
              ),
            if (usedAccount.id == user.id && !showDeleteButton)
              IconButton(
                icon: Icon(
                  Icons.check_circle,
                  color: InnoConfig.colors.successColor,
                ),
                onPressed: () {},
              ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) async {
    if (showDeleteButton) return;
    var result = await UsedAccountViewmodel().onSelectUsedAccount(usedAccount);
    if (result) {
      try {
        final viewmodel = UserViewmodel();
        final accessToken = await InnoSecureStorageService().getAccessToken(usedAccount.id);
        if (accessToken.isEmpty) {
          throw Exception("Empty access token");
        }

        final response = await viewmodel.loginWithAccessToken(accessToken);
        if (context.mounted) {
          CommonUtils.navigateToHomeTab0AndClearHistory(context);
        }
      } catch (e) {
        if (context.mounted) {
          CommonUtils.displayCustomDialog(
            context,
            AppLocalizations.of(context)!.loginRequired,
            [],
            const Icon(Icons.cancel_outlined),
            null,
            const Icon(Icons.login),
            () => null,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            true,
          );
        }
      }
    }
  }

  void _onDeleteTap() {
    if (!showDeleteButton) return;
    UsedAccountViewmodel().deleteUsedAccount(usedAccount.mobile);
  }
}
