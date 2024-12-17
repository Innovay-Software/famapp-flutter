import 'package:flutter/material.dart';

class ExpandedRowWidget extends StatelessWidget {
  double spacing = 0;
  String mainAlign = '';
  String crossAlign = '';
  MainAxisAlignment _mainAlign = MainAxisAlignment.center;
  CrossAxisAlignment _crossAlign = CrossAxisAlignment.center;
  List<Widget> children;

  ExpandedRowWidget({super.key, required this.children, String params = '0-c-c'}) {
    var paramParts = params.split('-');
    spacing = double.parse(paramParts[0]);
    mainAlign = paramParts[1];
    crossAlign = paramParts[2];
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
    _mainAlign = mainMap[mainAlign] ?? MainAxisAlignment.center;
    _crossAlign = crossMap[crossAlign] ?? CrossAxisAlignment.center;
  }

  List<Widget> buildChildrenList() {
    List<Widget> widgets = [];
    for (var i = 0; i < children.length; i++) {
      widgets.add(Expanded(child: children[i]));
      if (i < children.length - 1) {
        widgets.add(SizedBox(width: spacing));
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: _mainAlign, crossAxisAlignment: _crossAlign, children: buildChildrenList());
  }
}
