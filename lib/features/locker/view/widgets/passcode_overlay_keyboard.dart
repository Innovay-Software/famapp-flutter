import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class KeyboardUIConfig {
  //Digits have a round thin borders, [digitBorderWidth] define their thickness
  final double digitBorderWidth;
  final TextStyle digitTextStyle;
  final TextStyle deleteButtonTextStyle;
  final Color primaryColor;
  final Color digitFillColor;
  final EdgeInsetsGeometry keyboardRowMargin;
  final EdgeInsetsGeometry digitInnerMargin;

  //Size for the keyboard can be define and provided from the app.
  //If it will not be provided the size will be adjusted to a screen size.
  final Size? keyboardSize;

  const KeyboardUIConfig({
    this.digitBorderWidth = 1,
    this.keyboardRowMargin = const EdgeInsets.only(top: 15, left: 4, right: 4),
    this.digitInnerMargin = const EdgeInsets.all(24),
    this.primaryColor = Colors.white,
    this.digitFillColor = Colors.transparent,
    this.digitTextStyle = const TextStyle(fontSize: 30, color: Colors.white),
    this.deleteButtonTextStyle = const TextStyle(fontSize: 16, color: Colors.white),
    this.keyboardSize,
  });
}

class PasscodeOverlayKeyboard extends StatelessWidget {
  final KeyboardUIConfig keyboardUIConfig;
  final Function(String) onKeyboardTap;
  final _focusNode = FocusNode();
  static String deleteButton = 'keyboard_delete_button';

  //should have a proper order [1...9, 0]
  final List<String>? digits;

  PasscodeOverlayKeyboard({
    super.key,
    required this.keyboardUIConfig,
    required this.onKeyboardTap,
    this.digits,
  });

  @override
  Widget build(BuildContext context) {
    List<String> keyboardItems = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
    if (digits != null && digits!.isNotEmpty) {
      keyboardItems = digits!;
    }

    final screenSize = MediaQuery.of(context).size;
    final keyboardHeight = screenSize.height > screenSize.width ? screenSize.height / 2 : screenSize.height - 80;
    final keyboardWidth = keyboardHeight * 3 / 4;
    final keyboardSize =
        keyboardUIConfig.keyboardSize != null ? keyboardUIConfig.keyboardSize! : Size(keyboardWidth, keyboardHeight);
    return SizedBox(
      width: keyboardSize.width,
      height: keyboardSize.height,
      // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: RawKeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKey: (event) {
          if (event is RawKeyUpEvent) {
            if (keyboardItems.contains(event.data.keyLabel)) {
              onKeyboardTap(event.logicalKey.keyLabel);
              return;
            }
            if (event.logicalKey.keyLabel == 'Backspace' || event.logicalKey.keyLabel == 'Delete') {
              onKeyboardTap(PasscodeOverlayKeyboard.deleteButton);
              return;
            }
          }
        },
        child: AlignedGrid(
          keyboardSize: keyboardSize,
          children: List.generate(10, (index) {
            return _buildKeyboardDigit(keyboardItems[index]);
          }),
        ),
      ),
    );
  }

  Widget _buildKeyboardDigit(String text) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: keyboardUIConfig.primaryColor.withOpacity(0.4),
            onTap: () {
              onKeyboardTap(text);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: keyboardUIConfig.primaryColor.withOpacity(0.3),
                border: Border.all(color: keyboardUIConfig.primaryColor, width: keyboardUIConfig.digitBorderWidth),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: keyboardUIConfig.digitFillColor,
                ),
                child: Center(
                  child: Text(
                    text,
                    style: keyboardUIConfig.digitTextStyle,
                    semanticsLabel: text,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AlignedGrid extends StatelessWidget {
  final double runSpacing = 14;
  final double spacing = 14;
  final int listSize;
  final columns = 3;
  final List<Widget> children;
  final Size keyboardSize;

  const AlignedGrid({super.key, required this.children, required this.keyboardSize}) : listSize = children.length;

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    items.addAll(children);
    items.insert(items.length - 1, Container());
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: spacing,
      crossAxisSpacing: runSpacing,
      crossAxisCount: 3,
      children: items,
    );
  }
}
