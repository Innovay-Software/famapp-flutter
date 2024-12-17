import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/config.dart';
import '../../../../core/widgets/buttons/background_button.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../../../core/widgets/member_avatar.dart';
import '../../model/member_model.dart';
import '../member_detail_page.dart';

class MemberBar extends StatelessWidget {
  final Member member;

  const MemberBar({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 1),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: InnoConfig.colors.dividerLineColor)),
        color: InnoConfig.colors.backgroundColor,
      ),
      child: ListTile(
        title: InnoText(member.name, fontSize: 16),
        subtitle: InnoText(member.mobile, fontSize: 12, color: Colors.grey),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: MemberAvatarWidget(
            userId: member.id,
            userName: member.name,
            userRole: member.role,
            size: 40,
            showRoleIcon: true,
            clearCache: true,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InnovayBackgroundButton(
              '',
              InnoConfig.colors.primaryColor,
              () {
                _onEditTap(context);
              },
              prefixWidget: const Icon(Icons.edit_note, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  void _onEditTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemberDetailPage(
          pageTitle: member.id == 0 ? AppLocalizations.of(context)!.newMember : AppLocalizations.of(context)!.member,
          member: member,
          // onDeleteSuccessCallback: () {
          //   _members.remove(member);
          // },
        ),
      ),
    );
  }
}
