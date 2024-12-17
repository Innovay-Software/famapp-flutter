import 'package:flutter/material.dart';

import 'avatar.dart';

class MemberAvatarsBox extends StatelessWidget {
  final List<Map<String, dynamic>> members;
  final double avatarSize;
  final double borderRadius;

  const MemberAvatarsBox({
    super.key,
    required this.members,
    required this.avatarSize,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    while (members.length > 4) {
      members.removeLast();
    }
    // List<String> avatars = [];
    // for (var item in userIds) {
    //   avatars.add(InnovayConfig.mainNetworkConfig.userAvatar(item));
    //   if (avatars.length >= 4) break;
    // }
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        color: const Color(0x11000000),
        width: avatarSize * 2 + 3,
        height: avatarSize * 2 + 3,
        child: members.isEmpty || members.length == 1
            ? Center(
                child: members.isEmpty
                    ? const InnoAvatarDefault("")
                    : InnoAvatar(
                        url: '${members.first['url']}',
                        username: '${members.first['username']}',
                        size: avatarSize * 2 + 1,
                        borderRadius: 2,
                      ),
              )
            : Wrap(
                spacing: 1.0,
                runSpacing: 1.0,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: members.map((member) {
                  return InnoAvatar(
                    url: member['url'] ?? "",
                    username: member['username'] ?? "",
                    size: avatarSize,
                    borderRadius: avatarSize * 0.2,
                  );
                }).toList(),
              ),
      ),
    );
  }
}
