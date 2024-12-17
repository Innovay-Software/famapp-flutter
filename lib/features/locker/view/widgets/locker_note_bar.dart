import 'package:flutter/material.dart';
import 'package:famapp/core/utils/datetime_util.dart';

import '../../../../core/config.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../../../core/widgets/member_avatars.dart';
import '../../../../core/widgets/right_arrow.dart';
import '../../model/locker_note_model.dart';

class LockerNoteBar extends StatelessWidget {
  final LockerNote lockerNote;
  final Function() onTap;

  const LockerNoteBar({
    super.key,
    required this.lockerNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // var ids = <int>[lockerNote.owner['id']];
    // var userNames = <String>[lockerNote.owner['name']];
    // DebugManager.log("Locker ${lockerNote.id} has ${lockerNote.inviteeIds}");

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 1),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
          color: InnoConfig.colors.backgroundColor,
          border: Border(bottom: BorderSide(color: InnoConfig.colors.dividerLineColor)),
        ),
        child: Row(children: [
          MemberAvatarsBox(members: [lockerNote.owner, ...lockerNote.invitees], avatarSize: 20),
          // ClipRRect(
          //     borderRadius: BorderRadius.circular(100),
          //     child: InnovayAvatar(InnovayConfig.mainNetworkConfig.userAvatar(lockerNote.ownerId), 40)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InnoText(
                lockerNote.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 10),
              InnoText(
                DatetimeUtils.formattedDateTime(lockerNote.updatedAt.toLocal()),
                color: InnoConfig.colors.textColorLight7,
                fontSize: 12,
              ),
            ]),
          ),
          const InnovayRightArrow(),
        ]),
      ),
    );
  }
}
