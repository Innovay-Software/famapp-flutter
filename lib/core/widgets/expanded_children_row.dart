import 'package:flutter/material.dart';

class ExpandedChildrenRow extends StatelessWidget {
  final List<Widget> children;
  final String params;

  const ExpandedChildrenRow({super.key, required this.children, this.params = '0-c-c'});

  @override
  Widget build(BuildContext context) {
    var paramParts = params.split('-');
    var spacing = double.parse(paramParts[0]);
    var mainMap = {
      's': MainAxisAlignment.start,
      'c': MainAxisAlignment.center,
      'e': MainAxisAlignment.end,
      'sb': MainAxisAlignment.spaceBetween,
      'sa': MainAxisAlignment.spaceAround,
      'se': MainAxisAlignment.spaceEvenly
    };
    var crossMap = {
      's': CrossAxisAlignment.start,
      'c': CrossAxisAlignment.center,
      'e': CrossAxisAlignment.end,
    };
    var mainAlign = mainMap[paramParts[1]] ?? MainAxisAlignment.center;
    var crossAlign = crossMap[paramParts[2]] ?? CrossAxisAlignment.center;

    var widgets = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      widgets.add(Expanded(child: children[i]));
      if (spacing > 0 && i < children.length - 1) {
        widgets.add(SizedBox(width: spacing));
      }
    }
    return Row(mainAxisAlignment: mainAlign, crossAxisAlignment: crossAlign, children: widgets);
  }
}
