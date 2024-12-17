import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/config.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../model/locker_note_model.dart';

class LockerNoteEditAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool readonly;
  final bool isLoading;
  final LockerNote lockerNote;
  final Function() onEditTap;
  final Function() onDeleteTap;
  final Function() onSaveTap;
  final Function() onSettingsTap;
  @override
  final Size preferredSize;

  const LockerNoteEditAppBar({
    super.key,
    required this.readonly,
    required this.isLoading,
    required this.lockerNote,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.onSaveTap,
    required this.onSettingsTap,
  }) : preferredSize = const Size.fromHeight(40.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      toolbarHeight: 40,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: InnoConfig.colors.backgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      leadingWidth: 56,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context, false);
        },
        child: Container(
          color: InnoConfig.colors.backgroundColor,
          child: Center(child: Icon(CupertinoIcons.back, size: 22, color: InnoConfig.colors.textColor)),
        ),
      ),
      backgroundColor: InnoConfig.colors.backgroundColor,
      foregroundColor: InnoConfig.colors.textColor,
      elevation: 0,
      title: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 100),
            child: Row(children: [
              Expanded(
                child: readonly || isLoading
                    ? InnoText(lockerNote.title,
                        fontSize: 16, textAlign: TextAlign.start, color: InnoConfig.colors.textColor)
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          // color: InnovayConfig.colors.greyColor,
                        ),
                        child: TextField(
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.25,
                            color: InnoConfig.colors.textColor,
                          ),
                          minLines: 1,
                          maxLines: 1,
                          onChanged: (val) {
                            lockerNote.title = val;
                          },
                          controller: TextEditingController.fromValue(TextEditingValue(
                              text: lockerNote.title,
                              selection: TextSelection.collapsed(offset: lockerNote.title.length))),
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            isDense: true,
                            // icon: widget.prefixIcon,
                            hintText: '请输入标题',
                            hintStyle: TextStyle(fontSize: 12, color: InnoConfig.colors.textColorLight9),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(width: 1, color: InnoConfig.colors.textColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 1, color: InnoConfig.colors.textColor)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 1, color: InnoConfig.colors.textColor)),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                          // keyboardType: TextInputType.text,
                        ),
                      ),
              ),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              readonly || isLoading
                  ? IconButton(
                      onPressed: onSettingsTap, icon: Icon(Icons.settings, color: InnoConfig.colors.primaryColor))
                  : const SizedBox.shrink(),
              // IconButton(
              //         onPressed: onDeleteTap, icon: Icon(Icons.delete_outline, color: InnoConfig.colors.deleteColor)),
              readonly || isLoading
                  ? IconButton(onPressed: onEditTap, icon: Icon(Icons.edit, color: InnoConfig.colors.primaryColor))
                  : IconButton(onPressed: onSaveTap, icon: Icon(Icons.check, color: InnoConfig.colors.primaryColor))
            ],
          )
        ],
      ),
    );
  }
}
