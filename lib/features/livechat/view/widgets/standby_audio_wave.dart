import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StandbyAudioWave extends StatefulWidget {
  final Color color;
  const StandbyAudioWave({
    super.key,
    required this.color,
  });

  @override
  State<StandbyAudioWave> createState() => _StandbyAudioWaveState();
}

class _StandbyAudioWaveState extends State<StandbyAudioWave> with SingleTickerProviderStateMixin {
  final double _animationCycleLength = 2000;
  final double _animationBarCycleLength = 300;
  final int _animationStartTime = DateTime.now().millisecondsSinceEpoch;
  final int _barCount = 20;
  final double _barWidth = 2.0;
  final List<double> _barHeights = [];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _barCount; i++) {
      _barHeights.add(0);
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )
      ..repeat()
      ..addListener(() {
        var currentTime = DateTime.now().millisecondsSinceEpoch;
        var deltaTime = (currentTime - _animationStartTime) % _animationCycleLength;
        // print('deltaTime = $deltaTime');

        for (var i = 0; i < _barCount; i++) {
          var iAdjusted = (i - _barCount ~/ 2).abs();
          var indexTime = (deltaTime - iAdjusted * 100) / _animationBarCycleLength;
          var y = max(0, -pow(indexTime - 1, 2) + 1);
          // print('x, y = $indexTime, $y');
          _barHeights[i] = 10 + y * 15;
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _barHeights
            .map(
              (e) => Container(
                width: _barWidth,
                height: e,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
