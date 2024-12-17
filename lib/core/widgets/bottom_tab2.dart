// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class BottomTab2Page extends StatefulWidget {
//   final String title;
//
//   const BottomTab2Page({super.key, required this.title});
//
//   @override
//   State<BottomTab2Page> createState() => _BottomTab2PageState();
// }
//
// class _BottomTab2PageState extends State<BottomTab2Page> {
//   double _systemBarHeight = 0;
//   final double _topSectionHeight = 200;
//   final String _userName = '';
//
//   bool showLoginDialog = false;
//   bool showUploadDialog = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   List<Widget> buildAvatarWidgets(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var topBaseSize = 24.0;
//
//     var avatarDecorPositions = [
//       [width * 0.1, width * -0.03, 2 * topBaseSize],
//       [width * 0.08, width * 0.08, 1 * topBaseSize],
//       [width * 0.12, width * 0.16, 1.75 * topBaseSize],
//       [width * 0.1, width * 0.1, 4 * topBaseSize],
//       [width * 0.1, width * 0.3, 1.1 * topBaseSize],
//       [width * 0.08, width * 0.3, 3 * topBaseSize],
//       [width * 0.08, width * 0.43, 2 * topBaseSize],
//       [width * 0.1, width * 0.41, 3.8 * topBaseSize],
//       [width * 0.12, width * 0.55, 2.35 * topBaseSize],
//       [width * 0.08, width * 0.65, 1.2 * topBaseSize],
//       [width * 0.08, width * 0.67, 3.9 * topBaseSize],
//       [width * 0.1, width * 0.75, 2 * topBaseSize],
//       [width * 0.07, width * 0.83, 0.5 * topBaseSize],
//       [width * 0.1, width * 0.85, 3 * topBaseSize],
//       [width * 0.1, width * 0.95, 1.5 * topBaseSize],
//       [width * 0.07, width * 0.95, 4.5 * topBaseSize],
//     ];
//
//     List<Widget> widgetsList = [];
//     for (var i = 0; i < avatarDecorPositions.length; i++) {
//       widgetsList.add(Positioned(
//         left: avatarDecorPositions[i][1],
//         top: avatarDecorPositions[i][2],
//         child: Image.asset(
//           "assets/avatar/DefaultAvatar${i + 1}.png",
//           fit: BoxFit.contain,
//           width: avatarDecorPositions[i][0],
//           height: avatarDecorPositions[i][0],
//         ),
//       ));
//     }
//
//     return widgetsList;
//   }
//
//   void onSettingsButtonPressed(BuildContext context) {}
//
//   void onAddMediaButtonPressed() {}
//
//   void onCloseLoginDialogButtonPressed() {}
//
//   void onCloseUploadDialogButtonPressed() {}
//
//   void onFriendsButtonPressed() {}
//
//   void onAlbumsButtonPressed() {}
//
//   void onDownloadImageButtonPressed(String imageUrl) {}
//
//   @override
//   Widget build(BuildContext context) {
//     _systemBarHeight = MediaQuery.of(context).viewPadding.top;
//
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.black,
//       statusBarIconBrightness: Brightness.dark,
//       // For iOS.
//       // Use [dark] for white status bar and [light] for black status bar.
//       statusBarBrightness: Brightness.light,
//     ));
//     return Scaffold(
//       // appBar: AppBar(
//       //   // Here we take the value from the MyHomePage object that was created by
//       //   // the App.build method, and use it to set our appbar title.
//       //   title: Text(widget.title),
//       //   systemOverlayStyle:
//       //       const SystemUiOverlayStyle(statusBarColor: Colors.black),
//       // ),
//       body: Stack(children: [
//         Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           alignment: Alignment.topCenter,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             // padding: const EdgeInsets.all(0),
//             children: [
//               // SnackBar(content: Text('hahaha')),
//               Expanded(
//                 flex: 0,
//                 child: Stack(
//                   // alignment: const Alignment(0.6, 0.6),
//                   children: [
//                     // Background Avatar
//                     Container(
//                       height: _topSectionHeight,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           fit: BoxFit.fill,
//                           image: NetworkImage('https://innovay.app/img/logos/logo2_190x190.png'),
//                         ),
//                       ),
//                     ),
//                     // Frosted Glass Effect
//                     BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
//                       child: Container(height: _topSectionHeight, color: const Color(0x55FFFFFF)),
//                     ),
//                     // Header Bar
//                     Container(
//                       padding: EdgeInsets.only(top: _systemBarHeight, bottom: 10, left: 30, right: 30),
//                       color: const Color(0x22FFFFFF),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(_userName == '' ? '欢迎' : _userName),
//                           // Image.asset('assets/ui/SettingsIcon333.png',
//                           //     width: 25, height: 25),
//                           GestureDetector(
//                             onTap: () => onSettingsButtonPressed(context),
//                             child: Image.asset('assets/ui/SettingsIcon333.png', width: 25, height: 25),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Top Center Avatar
//                     Container(
//                       padding: EdgeInsets.only(top: _systemBarHeight + 5),
//                       width: MediaQuery.of(context).size.width,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 70,
//                             height: 70,
//                             // color: Colors.red,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               border: Border.all(
//                                 width: 5,
//                                 color: const Color(0x55FFFFFF),
//                               ),
//                             ),
//                             child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(100),
//                                 child: Image.network(
//                                   'https://innovay.app/img/logos/logo2_190x190.png',
//                                   fit: BoxFit.contain,
//                                 )),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Avatar Decoration
//                     Container(
//                       padding: EdgeInsets.only(top: _systemBarHeight + 30),
//                       height: _topSectionHeight,
//                       width: MediaQuery.of(context).size.width,
//                       // color: Colors.red,
//                       child: Stack(
//                         children: buildAvatarWidgets(context),
//                       ),
//                     ),
//                     // Gradient Overlay
//                     Positioned(
//                       left: 0,
//                       right: 0,
//                       top: _systemBarHeight + 35,
//                       bottom: 0,
//                       child: Container(
//                         padding: EdgeInsets.only(top: _systemBarHeight + 40),
//                         decoration: const BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               // Colors.red,
//                               // Colors.blue,
//                               Color(0x00FFFFFF),
//                               Color(0xFFFFFFFF),
//                             ],
//                             begin: FractionalOffset(0.5, 0.5),
//                             end: FractionalOffset(0.5, 1.0),
//                             stops: [0.0, 1.0],
//                             tileMode: TileMode.clamp,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.only(top: 0, bottom: 0, left: 15.0, right: 15.0),
//                   color: Colors.white,
//                   child: GridView.builder(
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 10.0,
//                       mainAxisSpacing: 10.0,
//                     ),
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return null;
//                     },
//                     itemCount: 0,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ]),
//     );
//   }
// }
