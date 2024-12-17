import 'package:flutter/material.dart';

import '../../../../core/config.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../model/member_model.dart';

class MemberSelectionMemberBar extends StatelessWidget {
  final Member member;
  final Function() onTap;
  final bool selected;
  const MemberSelectionMemberBar({super.key, required this.member, required this.onTap, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: InnoConfig.colors.greyColor),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.only(top: 1),
      child: Row(
        children: [
          InnoAvatarUserId(
            member.id,
            userName: member.name,
            size: 40,
            borderRadius: 100,
          ),
          const SizedBox(width: 10),
          InnoText(member.name),
          const Spacer(),
          GestureDetector(
            onTap: onTap,
            child: selected
                ? Icon(Icons.check_circle, size: 30, color: InnoConfig.colors.primaryColor)
                : const Icon(Icons.circle_outlined, size: 30, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
