import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../core/utils/debug_utils.dart';
import '../../../core/widgets/innovay_text.dart';
import '../../album/viewmodel/album_viewmodel.dart';
import '../model/album.dart';
import '../model/album_file.dart';
import 'widgets/media_slide_show_bottom_bar.dart';
import 'widgets/media_slide_show_item_clean_cached_video_player.dart';
import 'widgets/media_slide_show_item_clean_image.dart';
import 'widgets/media_slide_show_item_info_sheet.dart';

class MediaSlideShowPage extends StatefulWidget {
  final double paddingTop;
  final Album album;
  final int initialIndex;
  final double systemBarHeight;
  final DateTime pivotDate;

  const MediaSlideShowPage({
    super.key,
    required this.paddingTop,
    required this.album,
    required this.initialIndex,
    required this.systemBarHeight,
    required this.pivotDate,
  });

  @override
  State<MediaSlideShowPage> createState() => _MediaSlideShowPageState();
}

class _MediaSlideShowPageState extends State<MediaSlideShowPage> {
  late final PageController _pageController;
  late Function(int) updateBottomBarCallback;
  final FocusNode _remarkTextFieldFocusNode = FocusNode();
  // final UserViewmodel _userViewmodel = UserViewmodel();
  final AlbumViewmodel _albumViewmodel = AlbumViewmodel();
  TextEditingController _editingController = TextEditingController();
  String _remarkUserInput = '';
  int _currentIndex = 0;
  bool _isShowingRemarkTextField = false;
  bool _canEdit = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentIndex = widget.initialIndex;
    _canEdit = widget.album.canEditMediaFile(_currentIndex);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  }

  @override
  void dispose() {
    _remarkTextFieldFocusNode.dispose();
    // _keyboardSubscription.cancel();
    // _remarkTextFieldController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(children: [
        PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            if (widget.album.files[index].fileType == 'image') {
              return PhotoViewGalleryPageOptions.customChild(
                child: MediaSlideShowItemCleanImageWidget(albumFile: widget.album.files[index]),
                initialScale: PhotoViewComputedScale.contained * 1,
                heroAttributes: PhotoViewHeroAttributes(tag: widget.album.files[index].heroKeyThumbnail),
                minScale: .8,
                maxScale: 10.0,
                tightMode: false,
              );
            } else if (widget.album.files[index].fileType == 'video') {
              return PhotoViewGalleryPageOptions.customChild(
                child: MediaSlideShowItemCleanCachedVideoPlayerWidget(albumFile: widget.album.files[index]),
                initialScale: PhotoViewComputedScale.contained * 1,
                heroAttributes: PhotoViewHeroAttributes(tag: widget.album.files[index].heroKeyThumbnail),
                minScale: .8,
                maxScale: 10.0,
                tightMode: false,
              );
            }
            return PhotoViewGalleryPageOptions.customChild(
              child: InnoText('Unknown file type: ${widget.album.files[index].fileType}', color: Colors.white),
              initialScale: PhotoViewComputedScale.contained * 1,
              heroAttributes: PhotoViewHeroAttributes(tag: widget.album.files[index].heroKeyThumbnail),
              minScale: .8,
              maxScale: 5.0,
              tightMode: false,
            );
          },
          itemCount: widget.album.files.length,
          wantKeepAlive: false,
          gaplessPlayback: false,
          loadingBuilder: (context, event) => const Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                  // value: event == null
                  //     ? 0
                  //     : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                  ),
            ),
          ),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          pageController: _pageController,
          onPageChanged: _onPageChange,
        ),
        _isShowingRemarkTextField
            ? Positioned.fill(
                child: AbsorbPointer(child: Container(color: Colors.black.withOpacity(.1))),
              )
            : Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: MediaSlideShowBottomBar(
                  album: widget.album,
                  initialIndex: _currentIndex,
                  onInfoTap: _onInfoTap,
                  onKeyboardTap: _onKeyboardTap,
                  onPrivateTap: _onPrivateTap,
                  registerSetStateTrigger: _registerBottomBarSetStateTrigger,
                )),
        Visibility(
          visible: _isShowingRemarkTextField,
          child: Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Focus(
              canRequestFocus: true,
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  setState(() {
                    _isShowingRemarkTextField = false;
                    widget.album.files[_currentIndex].remark = _remarkUserInput;
                    _saveAlbumFile();
                  });
                }
              },
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 5),
                child: TextField(
                  focusNode: _remarkTextFieldFocusNode,
                  controller: _editingController,
                  autofocus: true,
                  onChanged: (text) {
                    _remarkUserInput = text;
                  },
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: 'Tap to add notes',
                    contentPadding: EdgeInsets.only(top: 12, bottom: 8, left: 5, right: 5),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                  minLines: 1,
                  maxLines: 10,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void _registerBottomBarSetStateTrigger(Function(int) callback) {
    updateBottomBarCallback = callback;
  }

  void _onPageChange(int index) async {
    _currentIndex = index;
    _canEdit = widget.album.canEditMediaFile(_currentIndex);
    updateBottomBarCallback(_currentIndex);
    if (index > widget.album.files.length - 10) {
      if (widget.album.hasMore) {
        await _albumViewmodel.loadFiles(
          album: _albumViewmodel.currentAlbum,
          forceReload: false,
          pivotDate: widget.pivotDate,
          startCallback: () => null,
        );
        setState(() {});
      }
    }
  }

  void _onEditRemarksTap(AlbumFile albumFile) {
    if (!_canEdit) {
      return;
    }
    _editingController = TextEditingController(text: albumFile.remark);
    _remarkUserInput = albumFile.remark;
    _isShowingRemarkTextField = true;
    setState(() {});

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(_remarkTextFieldFocusNode);
    });
  }

  void _onPrivateTap() {
    DebugManager.log("_onPrivateTap");
    if (!_canEdit) return;
    widget.album.files[_currentIndex].isPrivate = !widget.album.files[_currentIndex].isPrivate;

    setState(() {});
    _saveAlbumFile();
  }

  void _onKeyboardTap() {
    if (!_canEdit) return;
    _onEditRemarksTap(widget.album.files[_currentIndex]);
  }

  void _saveAlbumFile() {
    if (_canEdit) {
      _albumViewmodel.saveAlbumFile(albumFile: widget.album.files[_currentIndex]);
    }
  }

  void _onInfoTap() {
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: const Color(0xF2333333),
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        side: BorderSide.none,
      ),
      builder: (BuildContext context) {
        return MediaSlideShowItemInfoSheet(albumFile: widget.album.files[_currentIndex]);
      },
    );
  }
}
