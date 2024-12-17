import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/config.dart';
import '../../../../core/utils/debug_utils.dart';
import '../../../../core/widgets/innovay_text.dart';

class AlbumHomeDrawer extends StatefulWidget {
  final DateTime startingDate;
  final Function(DateTime) onMonthSelected;
  const AlbumHomeDrawer({super.key, required this.startingDate, required this.onMonthSelected});

  @override
  State<AlbumHomeDrawer> createState() => _AlbumHomeDrawerState();
}

class _AlbumHomeDrawerState extends State<AlbumHomeDrawer> {
  final ScrollController _scrollController = ScrollController();
  final List<DateTime> _monthList = [];

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    var currentMonth = DateTime(now.year, now.month);
    var startingMonthStart = DateTime(widget.startingDate.year, widget.startingDate.month);

    while (true) {
      if (currentMonth.isBefore(startingMonthStart)) break;
      _monthList.add(currentMonth);
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    }

    DebugManager.log('${widget.startingDate.toString()} month list: ${_monthList.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      surfaceTintColor: Colors.transparent,
      // backgroundColor: Colors.red,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
            itemCount: _monthList.length,
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var currentDatetime = _monthList[index];
              var monthWidget = GestureDetector(
                onTap: () {
                  widget.onMonthSelected(_monthList[index]);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  color: InnoConfig.colors.backgroundColorTinted3,
                  child: Center(
                    child: InnoText(
                      DateFormat('yyyy-MM').format(_monthList[index]),
                      fontSize: 12,
                      color: InnoConfig.colors.textColor,
                    ),
                  ),
                ),
              );

              List<Widget> result = [monthWidget];

              if (currentDatetime.month == 12) {
                result.insert(
                  0,
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: InnoText(
                      currentDatetime.year.toString(),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              }
              if (index == 0) {
                result.insert(
                  0,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Image.asset(
                      'assets/ui/baby/calendar.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              }
              if (result.length > 1) {
                return Column(crossAxisAlignment: CrossAxisAlignment.center, children: result);
              }
              return result.first;
            }),
      ),
    );
  }
}
