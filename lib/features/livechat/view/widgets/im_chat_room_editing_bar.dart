import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/config.dart';

class AlbumImChatRoomEditingBar extends StatelessWidget {
  final Function() onDeleteButtonTap;
  final Function() onSetCalendarDateTap;
  final Function() onMoveFilesTap;
  final Function() onCancelTap;

  const AlbumImChatRoomEditingBar({
    super.key,
    required this.onDeleteButtonTap,
    required this.onSetCalendarDateTap,
    required this.onMoveFilesTap,
    required this.onCancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70 + MediaQuery.of(context).padding.bottom,
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      decoration: BoxDecoration(
        gradient: InnoConfig.linearGradient,
        color: Colors.white.withOpacity(1),
        // border: Border.all(width: 2, color: Color(0xFF4158D0)),
        // borderRadius: BorderRadius.only(topLeft: Radius.circular(0)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  iconSize: 22,
                  icon: const Icon(CupertinoIcons.delete_simple),
                  color: Colors.white,
                  onPressed: onDeleteButtonTap,
                ),
                // IconButton(
                //   iconSize: 22,
                //   icon: const Icon(CupertinoIcons.calendar),
                //   color: Colors.white,
                //   onPressed: onSetCalendarDateTap,
                // ),
                // IconButton(
                //   iconSize: 22,
                //   icon: const Icon(CupertinoIcons.folder_badge_plus),
                //   color: Colors.white,
                //   onPressed: onMoveFilesTap,
                // ),
                IconButton(
                  iconSize: 22,
                  icon: const Icon(Icons.cancel_outlined),
                  color: Colors.white,
                  onPressed: onCancelTap,
                ),
              ]),
        ],
      ),
    );
  }
}
