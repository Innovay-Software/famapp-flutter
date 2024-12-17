import 'dart:async';

import 'package:flutter/material.dart';

import '../../features/album/view/album_file_downloader_page.dart';
import '../config.dart';
import '../global_data.dart';
import '../services/media_file_download_service.dart';
import 'innovay_text.dart';

class DownloadButtonOverlay extends StatefulWidget {
  const DownloadButtonOverlay({super.key});

  @override
  State<DownloadButtonOverlay> createState() => _DownloadButtonOverlayState();
}

class _DownloadButtonOverlayState extends State<DownloadButtonOverlay> {
  final MediaFileDownloadService _mediaFileDownloader = InnoGlobalData.mediaFileDownloader;
  final double buttonRadius = 23;
  late Timer _periodicUpdateTimer;
  Offset _currentGlobalPosition = const Offset(0, 500);
  // Offset _startDragOffset = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _periodicUpdateTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        _checkDownloadQueue();
      });
    });
  }

  @override
  void dispose() {
    _periodicUpdateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_mediaFileDownloader.jobs.isEmpty) {
      return const SizedBox.shrink();
    }
    return Positioned(
      left: _currentGlobalPosition.dx,
      top: _currentGlobalPosition.dy,
      child: GestureDetector(
        onPanUpdate: _onUpdateDrag,
        onPanDown: _onStartDrag,
        child: GestureDetector(
          onTap: _onTap,
          child: Container(
            width: buttonRadius * 2,
            height: buttonRadius * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: InnoConfig.colors.primaryColor,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Center(
              child: _mediaFileDownloader.isDownloading()
                  ? InnoText(
                      "${_mediaFileDownloader.getCurrentDownloadJobProgress()}%",
                      color: InnoConfig.colors.primaryColorTextColor,
                    )
                  : Icon(Icons.download, color: InnoConfig.colors.primaryColorTextColor),
            ),
          ),
        ),
      ),
    );
  }

  void _onUpdateDrag(DragUpdateDetails d) {
    _currentGlobalPosition = Offset(
        d.globalPosition.dx.clamp(buttonRadius, MediaQuery.of(context).size.width - buttonRadius) - buttonRadius,
        d.globalPosition.dy.clamp(buttonRadius * 2, MediaQuery.of(context).size.height - 100) - buttonRadius);
    setState(() {});
  }

  void _onStartDrag(DragDownDetails? d) {
    // if (d == null) return;
    // _startDragOffset = d.globalPosition - _currentGlobalPosition;
  }

  void _checkDownloadQueue() {
    setState(() {});
  }

  void _onTap() async {
    await Navigator.push(
      InnoGlobalData.bottomNavigatorContext!,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, _) {
          return const AlbumFileDownloaderPage();
          // return InnovayRadialTransition(
          //   startingPosition: _currentGlobalPosition + Offset(buttonRadius, buttonRadius),
          //   durationInMilliseconds: 1000,
          //   child: const MediaFileDownloaderView(),
          // );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // const begin = Offset(0.0, 1.0);
          // const end = Offset.zero;
          // var curve = Curves.ease;
          // var tween = Tween(begin: 0.0, end: 1.0);
          // final offsetAnimation = animation.drive(tween);
          //
          // return FadeTransition(opacity: animation.drive(tween), child: child);

          return LayoutBuilder(builder: (context, constraints) {
            return TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.linear,
              builder: (context, value, child) {
                var screenSize = MediaQuery.of(context).size;
                var cursorPosition = _currentGlobalPosition + Offset(buttonRadius, buttonRadius);
                var fractionalOffset = FractionalOffset(
                    cursorPosition.dx * 1.0 / screenSize.width, cursorPosition.dy * 1.0 / screenSize.height);

                return ShaderMask(
                  blendMode: BlendMode.dstATop,
                  shaderCallback: (rect) {
                    return RadialGradient(
                      radius: value * 5,
                      colors: const [Colors.white, Colors.white, Colors.transparent, Colors.transparent],
                      stops: const [0.0, 0.55, 0.6, 1.0],
                      center: fractionalOffset,
                    ).createShader(rect);
                  },
                  child: child,
                );
              },
              child: child,
            );
          });

          // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          // return SlideTransition(
          //   position: animation.drive(tween),
          //   child: child,
          // );
        },
      ),
    );
  }
}
