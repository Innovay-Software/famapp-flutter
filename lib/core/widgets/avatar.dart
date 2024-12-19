import 'package:flutter/material.dart';

import '../config.dart';
import 'cached_image.dart';
import 'innovay_text.dart';

class InnoAvatarUserId extends StatefulWidget {
  final int userId;
  final String userName;
  final double size;
  final double borderRadius;
  final bool clearCache;
  final String overrideUrl;

  const InnoAvatarUserId(
    this.userId, {
    super.key,
    this.userName = '',
    this.size = 40,
    this.borderRadius = 4,
    this.clearCache = false,
    this.overrideUrl = '',
  });

  @override
  State<InnoAvatarUserId> createState() => _InnoAvatarUserIdState();
}

class _InnoAvatarUserIdState extends State<InnoAvatarUserId> {
  String _url = '';
  String _userName = ' ';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // DebugManager.log('InnovayAvatar url = $_url');
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: const InnoText("Deprecated"),
      ),
    );
  }
}

class InnoAvatar extends StatelessWidget {
  final String url;
  final String userName;
  final double size;
  final double borderRadius;
  final bool clearCache;

  const InnoAvatar({
    super.key,
    this.url = '',
    this.userName = '',
    this.size = 40,
    this.borderRadius = 4,
    this.clearCache = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: InnovayCachedImage(
        url,
        errorText: userName.isEmpty ? "" : userName[0],
        errorBackgroundColor: InnoConfig.colors.primaryColorLighter,
        errorForegroundColor: InnoConfig.colors.primaryColorTextColor,
        errorTextSize: size * 0.4,
        errorWidget: InnoAvatarDefault(userName),
        width: size,
        height: size,
        fit: BoxFit.cover,
        clearCache: clearCache,
      ),
    );
  }
}

class InnoAvatarDefault extends StatelessWidget {
  final String userName;
  const InnoAvatarDefault(this.userName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: InnoConfig.colors.primaryColorLighter,
      child: Center(
        child: InnoText(
          userName.isEmpty ? "" : userName[0],
          color: InnoConfig.colors.primaryColorTextColor,
        ),
      ),
    );
  }
}
