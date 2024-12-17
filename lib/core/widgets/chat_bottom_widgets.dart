import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ChatBottomVoiceCallContainer extends StatefulWidget {
  final int imGroupId;
  const ChatBottomVoiceCallContainer({super.key, required this.imGroupId});

  @override
  State<ChatBottomVoiceCallContainer> createState() => ChatBottomVoiceCallContainerState();
}

class ChatBottomVoiceCallContainerState extends State<ChatBottomVoiceCallContainer> {
  late StreamSubscription<bool> keyboardSubscription;
  bool _isKeyboardShowing = false;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      onKeyboardVisibleChange(visible);
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  void onKeyboardVisibleChange(bool visible) {
    if (!mounted) return;
    setState(() {
      _isKeyboardShowing = visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 100, height: 100);
    // return _isKeyboardShowing ? SizedBox.shrink() : imVoiceCallUtil.generateImWindowVoiceCallSection(widget.imGroupId);
  }
}
