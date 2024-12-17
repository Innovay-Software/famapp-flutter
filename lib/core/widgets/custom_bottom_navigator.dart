import 'dart:math';

import 'package:flutter/material.dart';

import '../../features/album/view/album_home_page.dart';
import '../../features/livechat/view/livechat_home_page.dart';
import '../../features/settings/view/user_center_page.dart';
import '../config.dart';
import '../global_data.dart';
import '../utils/common_utils.dart';
import 'custom_bottom_navigation_bar.dart';

class CustomBottomNavigator extends StatefulWidget {
  const CustomBottomNavigator({super.key});

  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  late Function(int, bool, String) tab2SearchFunction;
  late PageController _pageController;
  int _currentTabIndex = InnoConfig.homeInitialTabIndex;
  // DateTime? lastPopTime;

  // final List<Function()> _pageViewSetStateCallbacks = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentTabIndex,
      viewportFraction: 1.0,
      keepPage: true,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      CommonUtils.checkForNewVersion(context, '');
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InnoGlobalData.bottomNavigatorContext = context;
    var body = PageView(
      controller: _pageController,
      pageSnapping: true,
      onPageChanged: (index) {
        _currentTabIndex = index;
        setState(() {});
      },
      children: const [
        LivechatHomePage(key: PageStorageKey('HomeTab0')),
        AlbumHomePage(key: PageStorageKey('HomeTab1')),
        UserCenterPage(key: PageStorageKey('HomeTab2')),
      ],
    );
    return Scaffold(
      backgroundColor: InnoConfig.colors.backgroundColor,
      body: body,
      extendBody: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        height: max(50, MediaQuery.of(context).padding.bottom * 0.8 + 40),
        currentIndex: _currentTabIndex,
        onTap: (index) async {
          _currentTabIndex = index;
          await _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          );
          if (mounted) {
            setState(() {});
          }
        },
      ),
      // onWillPop: () async {
      //   if (lastPopTime == null || DateTime.now().difference(lastPopTime!) > const Duration(seconds: 2)) {
      //     lastPopTime = DateTime.now();
      //     SnackBarManager.displayMessage('Tap again to quit');
      //     return false;
      //   } else {
      //     lastPopTime = null;
      //     return true;
      //   }
      // },
    );
  }
}
