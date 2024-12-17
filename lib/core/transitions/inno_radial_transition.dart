import 'package:flutter/material.dart';

class InnoRadialTransition extends StatelessWidget {
  final Widget child;
  final int durationInMilliseconds;
  final Curve curve;
  final Offset startingPosition;

  const InnoRadialTransition({
    super.key,
    required this.child,
    required this.startingPosition,
    this.durationInMilliseconds = 500,
    this.curve = Curves.linear,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var fractionalOffset =
        FractionalOffset(startingPosition.dx * 1.0 / screenSize.width, startingPosition.dy * 1.0 / screenSize.height);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(builder: (context, constraints) {
        return TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: durationInMilliseconds),
          curve: curve,
          builder: (context, value, child) {
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
      }),
    );
  }
}
