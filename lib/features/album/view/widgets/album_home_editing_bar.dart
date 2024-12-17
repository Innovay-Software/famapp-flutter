import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/config.dart';

class AlbumHomeEditingBar extends StatelessWidget {
  final Function() onDeleteButtonTap;
  final Function() onSetCalendarDateTap;
  final Function() onMoveFilesTap;
  final Function() onCancelTap;

  const AlbumHomeEditingBar({
    super.key,
    required this.onDeleteButtonTap,
    required this.onSetCalendarDateTap,
    required this.onMoveFilesTap,
    required this.onCancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width - 300) * 0.5, vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        // child: BackdropFilter(
        //   filter: ImageFilter.blur(
        //     sigmaX: 22.0,
        //     sigmaY: 22.0,
        //   ),
        child: Container(
          width: MediaQuery.of(context).size.width - 300,
          height: 50,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            gradient: InnoConfig.linearGradient,
            color: Colors.white.withOpacity(1),
            // border: Border.all(width: 2, color: Color(0xFF4158D0)),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                IconButton(
                  iconSize: 22,
                  icon: const Icon(CupertinoIcons.delete_simple),
                  color: Colors.white,
                  onPressed: onDeleteButtonTap,
                ),
                IconButton(
                  iconSize: 22,
                  icon: const Icon(CupertinoIcons.calendar),
                  color: Colors.white,
                  onPressed: onSetCalendarDateTap,
                ),
                IconButton(
                  iconSize: 22,
                  icon: const Icon(CupertinoIcons.folder_badge_plus),
                  color: Colors.white,
                  onPressed: onMoveFilesTap,
                ),
                IconButton(
                  iconSize: 22,
                  icon: const Icon(Icons.cancel_outlined),
                  color: Colors.white,
                  onPressed: onCancelTap,
                ),
              ]),
            ],
          ),
        ),
        // ),
      ),
    );
  }
}
