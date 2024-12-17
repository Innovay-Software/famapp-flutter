import 'package:famapp/core/utils/debug_utils.dart';
import 'package:famapp/core/widgets/buttons/primary_button.dart';
import 'package:famapp/features/settings/viewmodel/user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/inno_secure_storage_service.dart';
import '../widgets/buttons/background_outline_button.dart';

class InnoDebugOverlay extends StatefulWidget {
  const InnoDebugOverlay({super.key});

  @override
  State<InnoDebugOverlay> createState() => InnoDebugOverlayState();
}

class InnoDebugOverlayState extends State<InnoDebugOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _showPanel = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Start off-screen
      end: Offset.zero, // Slide to on-screen
    ).animate(_animationController);

    // _animationController.forward(); // Start the animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget debugPanel() {
    return SingleChildScrollView(
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          InnovayPrimaryButton(
            '',
            () => setState(() {
              _showPanel = false;
            }),
            prefixWidget: const Icon(CupertinoIcons.clear_circled_solid),
          )
        ]),
        InnovayBackgroundOutlineButton('Log Secure Storage', Colors.black, () {
          InnoSecureStorageService().logAllStorageData();
        }),
        InnovayBackgroundOutlineButton('Clear All Secure Storage', Colors.black, () {
          InnoSecureStorageService().clearAllCache();
        }),
        InnovayBackgroundOutlineButton('Log current user', Colors.black, () {
          DebugManager.log(UserViewmodel().currentUser.toJson());
        }),
      ]),
    );
  }

  Widget debugPanelButton() {
    return Positioned(
      bottom: 16,
      right: 16,
      child: SafeArea(
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          InnovayPrimaryButton(
            '',
            () => setState(() {
              _showPanel = true;
              _animationController.forward();
            }),
            prefixWidget: const Icon(Icons.bug_report),
          ),
        ]),
      ),
    );
    // return Positioned(
    //   right: 16,
    //   bottom: 16,
    //   child: FloatingActionButton(
    //     onPressed: () => setState(() {
    //       _showPanel = true;
    //     }),
    //     child: const Icon(Icons.bug_report),
    //   ),
    // );
    //  Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     InnovayPrimaryButton(
    //       '',
    //       () => setState(() {
    //         _showPanel = true;
    //       }),
    //       prefixWidget: const Icon(Icons.bug_report),
    //     )
    //   ],
    // );
  }

  @override
  Widget build(BuildContext context) {
    if (!_showPanel) {
      return debugPanelButton();
    }
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        color: Colors.white,
        child: SafeArea(child: debugPanel()),
      ),
    );
  }
}
