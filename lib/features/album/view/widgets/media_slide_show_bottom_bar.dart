import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/global_data.dart';
import '../../../../core/utils/datetime_util.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../../settings/viewmodel/user_viewmodel.dart';
import '../../model/album.dart';

class MediaSlideShowBottomBar extends StatefulWidget {
  final Album album;
  final int initialIndex;
  final Function() onInfoTap;
  final Function() onKeyboardTap;
  final Function() onPrivateTap;
  final Function(Function(int)) registerSetStateTrigger;

  const MediaSlideShowBottomBar({
    super.key,
    required this.album,
    required this.initialIndex,
    required this.onInfoTap,
    required this.onKeyboardTap,
    required this.onPrivateTap,
    required this.registerSetStateTrigger,
  });

  @override
  State<MediaSlideShowBottomBar> createState() => _MediaSlideShowBottomBarState();
}

class _MediaSlideShowBottomBarState extends State<MediaSlideShowBottomBar> {
  final UserViewmodel _userViewmodel = UserViewmodel();
  int _currentIndex = 0;
  bool _canEdit = false;
  bool _collapseRemark = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _updateCanEdit();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.registerSetStateTrigger(_updateWidget);
    });
  }

  void _updateWidget(int index) {
    _currentIndex = index;
    _updateCanEdit();
    setState(() {});
  }

  void _updateCanEdit() {
    _canEdit = widget.album.canEditMediaFile(_currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withOpacity(0.4), Colors.black.withOpacity(1)],
        ),
      ),
      padding: EdgeInsets.only(left: 15, right: 15, bottom: max(5, MediaQuery.of(context).padding.bottom + 5)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          InnoText(DatetimeUtils.formattedDate(widget.album.files[_currentIndex].shotAt), color: Colors.white),
          const Spacer(),
          if (_canEdit)
            IconButton(
              onPressed: widget.onPrivateTap,
              icon: widget.album.files[_currentIndex].isPrivate
                  ? const Icon(CupertinoIcons.lock, color: Colors.red)
                  : const Icon(CupertinoIcons.lock_open, color: Colors.green),
              color: Colors.white,
              iconSize: 22,
            ),
          IconButton(
            onPressed: _onHighQualityTap,
            icon: InnoGlobalData.isHighQualityMediaFileModeOn
                ? const Icon(Icons.hd_outlined, color: Colors.green, size: 24)
                : const Icon(Icons.hd_outlined, size: 24),
            color: Colors.white,
          ),
          if (_canEdit)
            IconButton(
              onPressed: widget.onKeyboardTap,
              icon: const Padding(padding: EdgeInsets.only(top: 4), child: Icon(Icons.comment_outlined)),
              color: Colors.white,
              iconSize: 22,
            ),
          IconButton(
            onPressed: widget.onInfoTap,
            icon: const Icon(Icons.info_outline_rounded),
            color: Colors.white,
          ),
        ]),
        if (widget.album.files[_currentIndex].remark.isNotEmpty)
          GestureDetector(
            onTap: _onExpandRemarksTap,
            child: Row(
              children: [
                Expanded(
                  child: _collapseRemark
                      ? Text(
                          widget.album.files[_currentIndex].remark,
                          maxLines: 1,
                          style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.white, fontSize: 12),
                        )
                      : Text(
                          widget.album.files[_currentIndex].remark,
                          style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.5),
                        ),
                ),
              ],
            ),
          ),
      ]),
    );
  }

  void _onExpandRemarksTap() {
    _collapseRemark = !_collapseRemark;
    setState(() {});
  }

  void _onHighQualityTap() {
    InnoGlobalData.isHighQualityMediaFileModeOn = !InnoGlobalData.isHighQualityMediaFileModeOn;
    setState(() {});
  }
}
