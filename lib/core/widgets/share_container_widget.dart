import 'dart:math';

import 'package:flutter/material.dart';

import '../config.dart';

enum ShareFileType { image, file }

class ShareContainer extends StatefulWidget {
  final String shareFilePath;
  final String shareText;
  const ShareContainer({
    super.key,
    required this.shareFilePath,
    required this.shareText,
  });

  @override
  State<ShareContainer> createState() => _ShareContainerState();
}

class _ShareContainerState extends State<ShareContainer> {
  late ShareFileType _shareFileType;
  late String _fileName;
  late bool _isWebFile;

  final TextStyle _optionTitleStyle = TextStyle(
    fontSize: 11,
    color: InnoConfig.colors.textColorLight3,
  );

  @override
  void initState() {
    super.initState();
    _fileName = widget.shareFilePath.split('/').last;
    _isWebFile = widget.shareFilePath.startsWith('http');
    if (['jpg', 'jpeg', 'png', 'gif', 'tiff', 'bmp'].contains(_fileName.split('.').last.toLowerCase())) {
      _shareFileType = ShareFileType.image;
    } else {
      _shareFileType = ShareFileType.file;
    }
  }

  // void _uploadFile(String localFilePath, Function(String) successCallback) async {
  //   final file = File(localFilePath);
  //   var bytes = await file.readAsBytes();
  //   var base64Encoded = base64.encode(bytes);
  //
  //   InnoGlobalData.switchLoadingOverlay(true);
  //   var res = await NetworkManager.postRequestSync(
  //     InnoConfig.mainNetworkConfig.fileFullUpload(),
  //     dataLoad: {
  //       'filename': _fileName,
  //       'base64EncodedFile': base64Encoded,
  //     },
  //   );
  //   successCallback(res['data']['url']);
  //   InnoGlobalData.switchLoadingOverlay(false);
  // }

  // void _onQqTap() async {
  //   InnovayGlobalData.switchLoadingOverlay(true);
  //   if (_shareFileType == ShareFileType.image) {
  //     final File file = _isWebFile
  //         ? (await DefaultCacheManager().getSingleFile(widget.shareFilePath))
  //         : File(widget.shareFilePath);
  //
  //     await TencentKitPlatform.instance
  //         .shareImage(scene: TencentScene.kScene_QQ, imageUri: Uri.file(file.path));
  //     InnovayGlobalData.switchLoadingOverlay(false);
  //   } else if (_shareFileType == ShareFileType.file) {
  //     if (_isWebFile) {
  //       await TencentKitPlatform.instance
  //           .shareWebpage(scene: TencentScene.kScene_QQ, title: _fileName, targetUrl: widget.shareFilePath);
  //       InnovayGlobalData.switchLoadingOverlay(false);
  //     } else {
  //       _uploadFile(widget.shareFilePath, (url) async {
  //         await TencentKitPlatform.instance
  //             .shareWebpage(scene: TencentScene.kScene_QQ, title: _fileName, targetUrl: url);
  //         InnovayGlobalData.switchLoadingOverlay(false);
  //       });
  //     }
  //   }
  // }

  // void _onWxChatTap() {
  //   _shareToWx(WeChatScene.SESSION);
  // }
  //
  // void _onWxTimelineTap() {
  //   _shareToWx(WeChatScene.TIMELINE);
  // }
  //
  // void _shareToWx(WeChatScene targetScene) async {
  //   InnovayGlobalData.switchLoadingOverlay(true);
  //   if (_shareFileType == ShareFileType.image) {
  //     await shareToWeChat(WeChatShareImageModel(
  //         _isWebFile
  //             ? WeChatImage.network(widget.shareFilePath)
  //             : WeChatImage.file(File(widget.shareFilePath)),
  //         title: _fileName,
  //         scene: targetScene));
  //   } else if (_shareFileType == ShareFileType.file) {
  //     await shareToWeChat(WeChatShareFileModel(
  //         _isWebFile ? WeChatFile.network(widget.shareFilePath) : WeChatFile.file(File(widget.shareFilePath)),
  //         title: _fileName,
  //         scene: targetScene));
  //   }
  //   InnovayGlobalData.switchLoadingOverlay(false);
  // }

  // void _onSmsTap() async {
  //   if (_isWebFile) {
  //     String result = await sendSMS(message: widget.shareFilePath, recipients: []).catchError((onError) {
  //       DebugManager.log(onError);
  //     });
  //   } else {
  //     _uploadFile(widget.shareFilePath, (url) async {
  //       String result = await sendSMS(message: url, recipients: []).catchError((onError) {
  //         DebugManager.log(onError);
  //       });
  //       InnovayGlobalData.switchLoadingOverlay(false);
  //     });
  //   }
  // }

  // void _onDownloadTap() async {
  //   DebugManager.log('_onDownloadTap');
  //   downloadFile(widget.shareFilePath, _onDownloadProgressCallback);
  // }

  // void _onDownloadProgressCallback(int progress) {
  //   DebugManager.log('_onDownloadProgressCallback: $progress');
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width / 10;
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero),
          color: InnoConfig.colors.backgroundColor,
        ),
        padding:
            EdgeInsets.only(left: 0, right: 0, top: 30, bottom: max(30, MediaQuery.of(context).padding.bottom + 15)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // GestureDetector(
                //   onTap: _onQqTap,
                //   child: Column(
                //     children: [
                //       Image.asset('assets/innovay/Share_QQ.png', width: size, height: size, fit: BoxFit.contain),
                //       InnovayText('QQ', style: _optionTitleStyle),
                //     ],
                //   ),
                // ),
                // GestureDetector(
                //   onTap: _onWxChatTap,
                //   child: Column(
                //     children: [
                //       Image.asset('assets/innovay/Share_WxChat.png',
                //           width: size, height: size, fit: BoxFit.contain),
                //       InnovayText('微信好友', style: _optionTitleStyle),
                //     ],
                //   ),
                // ),
                // GestureDetector(
                //   onTap: _onWxTimelineTap,
                //   child: Column(
                //     children: [
                //       Image.asset('assets/innovay/Share_WxTimeZone.png',
                //           width: size, height: size, fit: BoxFit.contain),
                //       InnovayText('朋友圈', style: _optionTitleStyle),
                //     ],
                //   ),
                // ),
                // GestureDetector(
                //   onTap: _onSmsTap,
                //   child: Column(
                //     children: [
                //       Image.asset('assets/innovay/Share_Sms.png', width: size, height: size, fit: BoxFit.contain),
                //       InnovayText('短信', style: _optionTitleStyle),
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ));
  }
}
