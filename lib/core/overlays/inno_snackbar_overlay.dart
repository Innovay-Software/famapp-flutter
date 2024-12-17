import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../utils/snack_bar_manager.dart';
import '../widgets/innovay_text.dart';

class InnoSnackBarOverlay extends StatefulWidget {
  const InnoSnackBarOverlay({Key? key}) : super(key: key);

  @override
  State<InnoSnackBarOverlay> createState() => InnoSnackBarOverlayState();
}

class InnoSnackBarOverlayState extends State<InnoSnackBarOverlay> {
  String _messageContent = '';
  bool _isShowingKeyboard = false;
  late StreamSubscription<bool> _keyboardSubscription;
  Timer? _messageTimer;

  @override
  void initState() {
    super.initState();
    SnackBarManager.overlayDisplayMessage = displayMessage;

    var keyboardVisibilityController = KeyboardVisibilityController();
    _keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _isShowingKeyboard = visible;
      });
    });
  }

  @override
  void dispose() {
    _keyboardSubscription.cancel();
    _messageTimer?.cancel();
    super.dispose();
  }

  void displayMessage(String content, int seconds) {
    setState(() {
      _messageContent = content;
      _messageTimer?.cancel();
      _messageTimer = Timer(Duration(seconds: seconds), () {
        setState(() {
          _messageContent = '';
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_messageContent.isEmpty) {
      return const SizedBox.shrink();
    }
    return Positioned(
        left: 0,
        right: 0,
        bottom: _isShowingKeyboard ? 10 : 100,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: MediaQuery.of(context).size.width - 60,
            ),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: const Color(0xAA000000), borderRadius: BorderRadius.circular(5)),
            child: InnoText(_messageContent, textAlign: TextAlign.center, color: const Color(0xFFFFFFFF)),
          )
        ]));
  }
}
