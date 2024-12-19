import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/innovay_text.dart';
import '../../../settings/viewmodel/user_viewmodel.dart';
import 'passcode_overlay.dart';

class LockerHomePasscodeOverlayPage extends StatefulWidget {
  final Function() onSuccessCallback;
  const LockerHomePasscodeOverlayPage({super.key, required this.onSuccessCallback});

  @override
  State<LockerHomePasscodeOverlayPage> createState() => _LockerHomePasscodeOverlayPageState();
}

class _LockerHomePasscodeOverlayPageState extends State<LockerHomePasscodeOverlayPage> {
  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();

  @override
  void initState() {
    super.initState();
  }

  void _onPasscodeEntered(String enteredPasscode) {
    final user = UserViewmodel().currentUser;
    bool isValid = user.lockerPasscode == md5.convert(utf8.encode(enteredPasscode)).toString();
    _verificationNotifier.add(isValid);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/aurora/aurora_g1.png',
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 22.0,
          sigmaY: 22.0,
        ),
        child: PasscodeOverlay(
          title: const InnoText('Passcode', color: Colors.white, fontSize: 18),
          passwordEnteredCallback: _onPasscodeEntered,
          shouldTriggerVerification: _verificationNotifier.stream,
          isValidCallback: widget.onSuccessCallback,
        ),
      ),
    ]);
  }
}
