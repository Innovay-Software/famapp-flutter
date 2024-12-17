import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/config.dart';
import '../../../../core/widgets/innovay_text.dart';

class AlbumHomeAppBar extends StatelessWidget {
  final double height;
  final String title;
  final Function(int) onActionButtonTap;

  const AlbumHomeAppBar({
    super.key,
    required this.height,
    required this.title,
    required this.onActionButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomTab0StatusBarClipper(),
      // child: BackdropFilter(
      //   filter: ImageFilter.blur(
      //     sigmaX: 12.0,
      //     sigmaY: 12.0,
      //   ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).viewPadding.top + height,
        color: Colors.white.withOpacity(0.999),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 15),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) => const LinearGradient(
                    // center: Alignment.topCenter,
                    begin: Alignment(-1, 1),
                    end: Alignment(1, -1),
                    stops: [0, 1],
                    colors: [Color(0xFF4158D0), Color(0xFFC850C0)]).createShader(bounds),
                child: InnoText(
                  title,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) => InnoConfig.linearGradient.createShader(bounds),
                child: IconButton(
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    onActionButtonTap(0);
                  },
                  icon: const Icon(CupertinoIcons.settings, size: 24),
                )),
            ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) => InnoConfig.linearGradient.createShader(bounds),
                child: IconButton(
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    onActionButtonTap(1);
                  },
                  icon: const Icon(CupertinoIcons.calendar, size: 24),
                ))
          ]),
        ),
      ),
      // ),
    );
    // return CustomPaint(
    //   painter: BottomTab0StatusBarPainter(),
    //   child: SizedBox(
    //       width: MediaQuery.of(context).size.width,
    //       height: MediaQuery.of(context).viewPadding.top + height,
    //       child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
    //           child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
    //             Padding(
    //               padding: const EdgeInsets.only(bottom: 10),
    //               child: InnovayText(
    //                 title,
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             const Spacer(),
    //             IconButton(
    //               padding: const EdgeInsets.all(10),
    //               constraints: const BoxConstraints(),
    //               onPressed: onSettingsTap,
    //               icon: Icon(Icons.settings, size: 20),
    //             )
    //           ]))),
    // );
  }

  // @override
  // Size get preferredSize => const Size.fromHeight(80.0);
}

class BottomTab0StatusBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var quarterCircleOffsetX = 60.0;
    var points = [
      Offset(size.width * 0.5 - quarterCircleOffsetX, size.height),
      Offset(size.width * 0.5 - quarterCircleOffsetX + 30, size.height - 20),
      Offset(size.width * 0.5 + quarterCircleOffsetX - 30, size.height - 20),
      Offset(size.width * 0.5 + quarterCircleOffsetX, size.height),
    ];

    var offset = 30;
    var customPath = Path()
      ..lineTo(0, size.height)
      ..lineTo(points[0].dx, points[0].dy)
      ..cubicTo(size.width * 0.5 - 20, size.height, size.width * 0.5 - offset - 10, size.height - offset,
          size.width * 0.5, size.height - offset)
      ..cubicTo(size.width * 0.5 + offset + 10, size.height - offset, size.width * 0.5 + 20, size.height, points[3].dx,
          points[3].dy)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return customPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
