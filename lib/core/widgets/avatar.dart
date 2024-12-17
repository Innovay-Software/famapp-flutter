import 'package:flutter/material.dart';

import '../config.dart';
import '../utils/cache_utils.dart';
import '../utils/debug_utils.dart';
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
    _url = widget.overrideUrl;
    if (_url == '') {
      _url = CacheUtils.getAvatar(widget.userId);
    }
    if (widget.userName.isNotEmpty) {
      _userName = widget.userName;
    }
  }

  @override
  Widget build(BuildContext context) {
    // DebugManager.log('InnovayAvatar url = $_url');
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: InnovayCachedImage(
        _url,
        errorText: _userName[0],
        errorBackgroundColor: InnoConfig.colors.primaryColorLighter,
        errorForegroundColor: InnoConfig.colors.primaryColorTextColor,
        errorTextSize: widget.size * 0.4,
        errorWidget: InnoAvatarDefault(_userName),
        width: widget.size,
        height: widget.size,
        fit: BoxFit.cover,
        clearCache: widget.clearCache,
      ),
    );
  }
}

class InnoAvatar extends StatelessWidget {
  final String url;
  final String username;
  final double size;
  final double borderRadius;
  final bool clearCache;

  const InnoAvatar({
    super.key,
    this.url = '',
    this.username = '',
    this.size = 40,
    this.borderRadius = 4,
    this.clearCache = false,
  });

  @override
  Widget build(BuildContext context) {
    DebugManager.log('InnovayAvatar url = $url');
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: InnovayCachedImage(
        url,
        errorText: username.isEmpty ? "" : username[0],
        errorBackgroundColor: InnoConfig.colors.primaryColorLighter,
        errorForegroundColor: InnoConfig.colors.primaryColorTextColor,
        errorTextSize: size * 0.4,
        errorWidget: InnoAvatarDefault(username),
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
