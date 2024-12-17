import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../config.dart';
import '../global_data.dart';
import '../widgets/buttons/text_button.dart';

class InnoLoadingOverlay extends StatefulWidget {
  const InnoLoadingOverlay({super.key});

  @override
  State<InnoLoadingOverlay> createState() => InnoLoadingOverlayState();
}

class InnoLoadingOverlayState extends State<InnoLoadingOverlay> {
  bool _isLoading = false;
  final double _size = 100;

  @override
  void initState() {
    super.initState();
    InnoGlobalData.switchLoadingOverlay = (bool val) {
      if (val == _isLoading) return;
      setState(() {
        _isLoading = val;
      });
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoading) return const SizedBox.shrink();
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        color: const Color(0x01FFFFFF),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: InnoConfig.colors.loadingGreyTransparentBackgroundColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.white,
                    size: _size * 0.4,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InnovayTextButton(AppLocalizations.of(context)!.cancel, () {
                        InnoGlobalData.switchLoadingOverlay(false);
                      }, color: InnoConfig.colors.primaryColorTextColor, fontSize: 12)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
