import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/config.dart';
import '../../../../core/utils/common_utils.dart';
import '../../../../core/utils/debug_utils.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../model/livechat_group.dart';
import '../../model/livechat_message.dart';
import 'im_card_audio.dart';

class ImCard extends StatefulWidget {
  final double maxWidth;
  final LivechatGroupModel livechatGroup;
  final LivechatMessageModel livechatMessage;
  final AudioPlayer audioPlayer;
  final Function() onTap;
  final Function(String) onLongPress;

  const ImCard({
    super.key,
    required this.maxWidth,
    required this.livechatGroup,
    required this.livechatMessage,
    required this.audioPlayer,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  State<ImCard> createState() => _ImCardState();
}

class _ImCardState extends State<ImCard> {
  bool _isSelf = false;
  Color _backgroundColor = Colors.white;
  Color _foregroundColor = Colors.black;
  double _padding = 10;

  @override
  void initState() {
    super.initState();

    _isSelf = widget.livechatMessage.isOwner();
    _backgroundColor = _isSelf ? const Color(0xFF8DE768) : const Color(0xFFFFFFFF);
    //InnoConfig.colors.primaryColorLighter.withAlpha(80) : InnoConfig.colors.backgroundColor;
    _foregroundColor =
        const Color(0xFF191919); // _isSelf ? InnoConfig.colors.primaryColorTextColor : InnoConfig.colors.textColor;
    if (['image', 'video', 'audio'].contains(widget.livechatMessage.type)) {
      _padding = 0;
    }
  }

  Widget _createContentWidget() {
    if (widget.livechatMessage.type == ImMessageType.image) {
      return _createImageContentWidget();
    } else if (widget.livechatMessage.type == ImMessageType.video) {
      return _createVideoContentWidget();
    } else if (widget.livechatMessage.type == ImMessageType.audio) {
      return _createAudioContentWidget();
    }
    return InnoText(widget.livechatMessage.content, color: _foregroundColor);
  }

  Widget _createImageContentWidget() {
    var imageLink = widget.livechatMessage.content;
    if (widget.livechatMessage.fileUploadItem != null) {
      if (widget.livechatMessage.fileUploadItem!.localPath.isNotEmpty) {
        imageLink = widget.livechatMessage.fileUploadItem!.localPath;
      } else if (widget.livechatMessage.fileUploadItem!.remoteUrl.isNotEmpty) {
        imageLink = widget.livechatMessage.fileUploadItem!.remoteUrl;
      }
      if (widget.livechatMessage.fileUploadItem!.isUploading) {
        Future.delayed(const Duration(seconds: 1), () {
          DebugManager.log("timeout");
          if (!mounted) return;
          setState(() {});
        });
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: () {
          CommonUtils.displayImageFullScreenBottomSheet(context, [imageLink], 0);
        },
        onLongPress: _onLongPress,
        child: Stack(
          children: [
            Container(
              color: InnoConfig.colors.backgroundColor,
              child: InnovayCachedImage(imageLink, width: widget.maxWidth * 0.67, fit: BoxFit.cover),
            ),
            if (widget.livechatMessage.fileUploadItem != null && widget.livechatMessage.fileUploadItem!.isUploading)
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      value: widget.livechatMessage.fileUploadItem!.uploadProgress / 100.0,
                      backgroundColor: Colors.white,
                      color: InnoConfig.colors.primaryColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _createVideoContentWidget() {
    return SizedBox.square();
    // if (!widget.livechatMessage.hasVideoThumbnail()) {
    //   widget.livechatMessage.generateVideoThumbnail(() {
    //     setState(() {});
    //   });
    // }
    //
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(4),
    //   child: InkWell(
    //     onTap: () {
    //       if (!widget.livechatMessage.hasVideoThumbnail()) {
    //         return;
    //       }
    //       CommonUtils.displayVideoFullScreenBottomSheet(
    //           context, widget.livechatMessage.localVideoThumbnailPath, widget.livechatMessage.body, {});
    //     },
    //     onLongPress: _onLongPress,
    //     child: Stack(
    //       children: [
    //         Container(
    //           color: InnoConfig.colors.backgroundColor,
    //           child: widget.livechatMessage.hasVideoThumbnail()
    //               ? InnovayCachedImage(
    //                   widget.livechatMessage.localVideoThumbnailPath,
    //                   width: widget.maxWidth * 0.67,
    //                   fit: BoxFit.cover,
    //                 )
    //               : SizedBox(
    //                   width: widget.maxWidth * 0.67,
    //                   height: widget.maxWidth * 0.67,
    //                   child: const Icon(Icons.video_collection_outlined)),
    //         ),
    //         const Positioned(
    //           top: 2,
    //           right: 2,
    //           child: Icon(
    //             Icons.videocam_rounded,
    //             color: Colors.white60,
    //             size: 22,
    //           ),
    //         ),
    //         if (widget.livechatMessage.fileUploadItem != null && widget.livechatMessage.fileUploadItem!.isUploading)
    //           Positioned(
    //             left: 0,
    //             right: 0,
    //             top: 0,
    //             bottom: 0,
    //             child: Container(
    //               color: Colors.white.withOpacity(0.5),
    //               child: Center(
    //                 child: CircularProgressIndicator(
    //                   value: widget.livechatMessage.fileUploadItem!.uploadProgress / 100.0,
    //                   backgroundColor: Colors.white,
    //                   color: InnoConfig.colors.primaryColor,
    //                 ),
    //               ),
    //             ),
    //           ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _createAudioContentWidget() {
    return SizedBox(
        width: widget.maxWidth * 0.67,
        height: 44,
        child: ImCardAudio(
          livechatMessage: widget.livechatMessage,
          audioPlayer: widget.audioPlayer,
          onLongPress: _onLongPress,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: widget.maxWidth,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: _backgroundColor,
        elevation: 0,
        borderOnForeground: false,
        child: Padding(padding: EdgeInsets.all(_padding), child: _createContentWidget()),
      ),
    );
  }

  void _onLongPress() {
    widget.onLongPress(widget.livechatMessage.id);
  }
}
