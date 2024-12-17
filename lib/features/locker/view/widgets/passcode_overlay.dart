import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/innovay_text.dart';
import 'passcode_overlay_circle.dart';
import 'passcode_overlay_keyboard.dart';
import 'passcode_overlay_shake_curve.dart';

class PasscodeOverlay extends StatefulWidget {
  final Widget title;
  final int passwordDigits;
  final Function(String text) passwordEnteredCallback;
  // Cancel button and delete button will be switched based on the screen state
  final Stream<bool> shouldTriggerVerification;
  final CircleUIConfig circleUIConfig;
  final KeyboardUIConfig keyboardUIConfig;

  //isValidCallback will be invoked after passcode screen will pop.
  final Function()? isValidCallback;
  final Function()? cancelCallback;

  final Widget? bottomWidget;
  final List<String>? digits;

  const PasscodeOverlay({
    super.key,
    required this.title,
    required this.passwordEnteredCallback,
    required this.shouldTriggerVerification,
    this.passwordDigits = 6,
    this.isValidCallback,
    CircleUIConfig? circleUIConfig,
    KeyboardUIConfig? keyboardUIConfig,
    this.bottomWidget,
    this.cancelCallback,
    this.digits,
  })  : circleUIConfig = circleUIConfig ?? const CircleUIConfig(),
        keyboardUIConfig = keyboardUIConfig ?? const KeyboardUIConfig();

  @override
  State<StatefulWidget> createState() => _PasscodeOverlayState();
}

class _PasscodeOverlayState extends State<PasscodeOverlay> with SingleTickerProviderStateMixin {
  late StreamSubscription<bool> streamSubscription;
  String enteredPasscode = '';
  late AnimationController controller;
  late Animation<double> animation;

  @override
  initState() {
    super.initState();
    streamSubscription = widget.shouldTriggerVerification.listen((isValid) => _showValidation(isValid));
    controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    final Animation curve = CurvedAnimation(parent: controller, curve: PasscodeOverlayShakeCurve());
    animation = Tween(begin: 0.0, end: 10.0).animate(curve as Animation<double>)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            enteredPasscode = '';
            controller.value = 0;
          });
        }
      })
      ..addListener(() {
        setState(() {
          // the animation object’s value is the changed state
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.01),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? _buildPortraitPasscodeScreen()
                : _buildLandscapePasscodeScreen();
          },
        ),
      ),
    );
  }

  _buildPortraitPasscodeScreen() => Stack(
        children: [
          Positioned(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.title,
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 30),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildCircles(),
                    ),
                  ),
                  _buildKeyboard(),
                  widget.bottomWidget ?? Container(),
                ],
              ),
            ),
          ),
          Positioned(
              child: Align(
            alignment: Alignment.bottomLeft,
            child: _buildResetPasscodeButton(),
          )),
          Positioned(
            child: Align(
              alignment: Alignment.bottomRight,
              child: _buildDeleteButton(),
            ),
          ),
        ],
      );

  _buildLandscapePasscodeScreen() => Stack(
        children: [
          Positioned(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.title,
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: _buildCircles(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        widget.bottomWidget != null
                            ? Positioned(
                                child: Align(alignment: Alignment.topCenter, child: widget.bottomWidget),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  _buildKeyboard(),
                ],
              ),
            ),
          ),
          Positioned(
              child: Align(
            alignment: Alignment.bottomLeft,
            child: _buildResetPasscodeButton(),
          )),
          Positioned(
            child: Align(
              alignment: Alignment.bottomRight,
              child: _buildDeleteButton(),
            ),
          ),
        ],
      );

  Widget _buildKeyboard() {
    return PasscodeOverlayKeyboard(
      onKeyboardTap: _onKeyboardButtonPressed,
      keyboardUIConfig: widget.keyboardUIConfig,
      digits: widget.digits,
    );
  }

  List<Widget> _buildCircles() {
    var list = <Widget>[];
    var config = widget.circleUIConfig;
    var extraSize = animation.value;
    for (int i = 0; i < widget.passwordDigits; i++) {
      list.add(
        Container(
          margin: const EdgeInsets.all(8),
          child: PasscodeOverlayCircle(
            filled: i < enteredPasscode.length,
            circleUIConfig: config,
            extraSize: extraSize,
          ),
        ),
      );
    }
    return list;
  }

  _onDeleteCancelButtonPressed() {
    if (enteredPasscode.isNotEmpty) {
      setState(() {
        enteredPasscode = enteredPasscode.substring(0, enteredPasscode.length - 1);
      });
    } else {
      if (widget.cancelCallback != null) {
        widget.cancelCallback!();
      }
    }
  }

  _onKeyboardButtonPressed(String text) async {
    if (text == PasscodeOverlayKeyboard.deleteButton) {
      _onDeleteCancelButtonPressed();
      return;
    }
    if (enteredPasscode.length < widget.passwordDigits) {
      enteredPasscode += text;
      if (enteredPasscode.length == widget.passwordDigits) {
        setState(() {});
        await Future.delayed(const Duration(milliseconds: 300));
        widget.passwordEnteredCallback(enteredPasscode);
        return;
      }
    }
    setState(() {});
  }

  @override
  didUpdateWidget(PasscodeOverlay old) {
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
    if (widget.shouldTriggerVerification != old.shouldTriggerVerification) {
      streamSubscription.cancel();
      streamSubscription = widget.shouldTriggerVerification.listen((isValid) => _showValidation(isValid));
    }
  }

  @override
  dispose() {
    controller.dispose();
    streamSubscription.cancel();
    super.dispose();
  }

  _showValidation(bool isValid) {
    if (isValid) {
      _validationCallback();
    } else {
      controller.forward();
    }
  }

  _validationCallback() {
    if (widget.isValidCallback != null) {
      widget.isValidCallback!();
    } else {
      if (kDebugMode) {
        print("You didn't implement validation callback. Please handle a state by yourself then.");
      }
    }
  }

  Widget _buildDeleteButton() {
    if (enteredPasscode.isEmpty) return const SizedBox.shrink();
    return CupertinoButton(
      onPressed: _onDeleteCancelButtonPressed,
      child: Container(
        margin: widget.keyboardUIConfig.digitInnerMargin,
        child: const InnoText('Delete', color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildResetPasscodeButton() {
    return CupertinoButton(
      onPressed: () {
        Navigator.pop(context);
        // SnackBarManager.displayMessage('请联系管理员');
      },
      child: Container(
        margin: widget.keyboardUIConfig.digitInnerMargin,
        child: const InnoText('Cancel', color: Colors.white, fontSize: 16),
      ),
    );
  }
}
