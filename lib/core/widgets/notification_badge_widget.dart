import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../global_data.dart';

class InnoBadge extends StatefulWidget {
  final String notificationKey;

  const InnoBadge({super.key, required this.notificationKey});

  @override
  State<InnoBadge> createState() => _InnoBadgeState();
}

class _InnoBadgeState extends State<InnoBadge> {
  late String _notificationListenerKey;

  @override
  void initState() {
    super.initState();
    _notificationListenerKey = InnoGlobalData.notificationService.registerListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    InnoGlobalData.notificationService.unregisterListener(_notificationListenerKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var notificationCount = InnoGlobalData.notificationService.getNotificationCount(
      widget.notificationKey,
    );
    if (notificationCount <= 0) {
      return const SizedBox.shrink();
    }
    return badges.Badge(
      badgeContent: Text(
        '${notificationCount > 99 ? '99+' : notificationCount}',
        style: const TextStyle(color: Colors.white, fontSize: 10, height: 1.2),
      ),
      // child: Icon(Icons.settings),
    );
  }
}
