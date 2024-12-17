import 'package:flutter/material.dart';

import '../config.dart';
import 'avatar.dart';

class MemberAvatarWidget extends StatelessWidget {
  final int userId;
  final String userName;
  final String userRole;
  final double size;
  final bool showRoleIcon;
  final bool clearCache;

  const MemberAvatarWidget({
    super.key,
    required this.userId,
    required this.userName,
    required this.userRole,
    required this.size,
    required this.showRoleIcon,
    required this.clearCache,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: InnoConfig.colors.primaryColorLighter,
        ),
        padding: const EdgeInsets.all(1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: InnoAvatarUserId(
            userId,
            userName: userName,
            size: size,
            clearCache: clearCache,
          ),
        ),
      ),
      if (userRole == 'admin' && showRoleIcon)
        Positioned(
          top: -4,
          right: -6,
          child: Icon(
            Icons.admin_panel_settings,
            color: Colors.black.withOpacity(0.8),
            size: 20,
          ),
        ),
      if (userRole == 'admin' && showRoleIcon)
        const Positioned(
          top: -3,
          right: -5,
          child: Icon(
            Icons.admin_panel_settings,
            color: Colors.green,
            size: 18,
          ),
        ),
    ]);
  }
}
