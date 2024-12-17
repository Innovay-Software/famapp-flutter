// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../innovay/widgets/innovay_text.dart';
// import '../../../../innovay/widgets/right_arrow.dart';
//
// class UserCenterLinkBar extends StatelessWidget {
//   final double marginTop;
//   final IconData prefixIcon;
//   final Color iconColor;
//   final String title;
//   final String subTitle;
//   final VoidCallback onTap;
//
//   const UserCenterLinkBar({
//     super.key,
//     required this.marginTop,
//     required this.prefixIcon,
//     required this.iconColor,
//     required this.title,
//     required this.subTitle,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.only(left: 25, right: 15, top: 15, bottom: 15),
//         margin: EdgeInsets.only(top: marginTop),
//         // color: BabyConfig.colors.backgroundColor,
//         child: Row(children: [
//           Icon(prefixIcon, size: 32, color: iconColor),
//           const SizedBox(width: 15),
//           InnovayText(title, fontSize: 14),
//           const Spacer(),
//           InnovayText(subTitle, fontSize: 12),
//           const InnovayRightArrow()
//         ]),
//       ),
//     );
//   }
// }
