import 'dart:math';

import 'package:famapp/core/utils/debug_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'expanded_children_row.dart';
import 'notification_badge_widget.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final double height;
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.height,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // var linearGradient = const LinearGradient(
    //     // center: Alignment.topCenter,
    //     begin: Alignment(-1, 1),
    //     end: Alignment(1, -1),
    //     stops: [.3, .9, 1],
    //     colors: [Color(0xFF4158D0), Color(0xFFC850C0), Color(0xFFFFCC70)]);
    return ClipPath(
      clipper: BottomNavigatorClipper(),
      // child: BackdropFilter(
      //   filter: ImageFilter.blur(
      //     sigmaX: 22.0,
      //     sigmaY: 22.0,
      //   ),
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
        width: MediaQuery.of(context).size.width,
        height: height,
        color: const Color(0xFFDDDDDD),
        child: Align(
          alignment: Alignment.topCenter,
          child: ExpandedChildrenRow(children: [
            GestureDetector(
              onTap: () {
                onTap(0);
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(10),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    currentIndex == 0 ? CupertinoIcons.chat_bubble_2_fill : CupertinoIcons.chat_bubble_2,
                    size: 24,
                  ),
                  const InnoBadge(notificationKey: 'imTotal'),
                ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                onTap(1);
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(bottom: 15, top: 5, left: 10, right: 10),
                child: Icon(currentIndex == 1 ? Icons.photo : Icons.photo_outlined, size: 24),
              ),
            ),
            GestureDetector(
              onTap: () {
                onTap(2);
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(10),
                child: Icon(currentIndex == 2 ? Icons.person : Icons.person_outline_rounded, size: 24),
              ),
            ),
          ]),
        ),
        // ),
      ),
    );
  }
}

class BottomNavigatorClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var radiusToSizeMultiplier = 2.0;
    var radius = size.width * radiusToSizeMultiplier;
    var temp = sqrt(pow(radius, 2) - pow(size.width / 2, 2));
    var initialOffsetY = radius - temp;
    var path = Path()
      ..moveTo(0, initialOffsetY)
      ..arcToPoint(
        Offset(size.width, initialOffsetY),
        radius: Radius.circular(radius),
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
