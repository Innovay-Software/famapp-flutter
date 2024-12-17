import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../config.dart';
import 'right_arrow.dart';

class UserInputBar extends StatelessWidget {
  final bool mandatory;
  final String title;
  final String initialValue;
  final Function(String) onUserInput;
  final TextInputType textInputType;

  const UserInputBar({
    super.key,
    required this.mandatory,
    required this.title,
    required this.initialValue,
    required this.onUserInput,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      color: InnoConfig.colors.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 5),
          Text(title, style: TextStyle(color: InnoConfig.colors.textColor)),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: initialValue,
                  selection: TextSelection.collapsed(offset: initialValue.length),
                ),
              ),
              onChanged: onUserInput,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: '${AppLocalizations.of(context)!.pleaseEnter}$title',
                hintStyle: const TextStyle(fontSize: 14),
              ),
              keyboardType: textInputType,
            ),
          ),
        ],
      ),
    );
  }
}

class UserSelectionBar extends StatelessWidget {
  final bool mandatory;
  final String title;
  final String value;
  final Function() onTap;
  const UserSelectionBar({
    super.key,
    required this.mandatory,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 8, right: 5, bottom: 8),
      color: InnoConfig.colors.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 5),
          Text(title, style: TextStyle(color: InnoConfig.colors.textColor)),
          const SizedBox(width: 15),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  value.isEmpty
                      ? Text('${AppLocalizations.of(context)!.pleaseSelect}$title',
                          style: TextStyle(color: InnoConfig.colors.greyColorTextColor))
                      : Text(value, style: TextStyle(color: InnoConfig.colors.textColor)),
                  const SizedBox(width: 15),
                  InnovayRightArrow(onTap: onTap)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataDisplayBar extends StatelessWidget {
  final String title;
  final String content;
  final double titleWidth;
  static final TextStyle titleStyle = TextStyle(
    fontSize: 14,
    color: InnoConfig.colors.textColorLight7,
  );
  static final TextStyle contentStyle = TextStyle(
    fontSize: 16,
    color: InnoConfig.colors.textColor,
  );

  const DataDisplayBar({
    super.key,
    required this.title,
    required this.content,
    required this.titleWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: titleWidth, child: Text(title, style: titleStyle)),
          Expanded(
            child: Text(content, style: contentStyle),
          ),
        ],
      ),
    );
  }
}
