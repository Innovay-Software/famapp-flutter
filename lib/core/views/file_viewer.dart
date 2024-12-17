import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../config.dart';
import '../global_data.dart';
import '../utils/common_utils.dart';
import '../utils/debug_utils.dart';
import '../utils/network_utils.dart';
import '../widgets/buttons/bottom_picker_action_button_row.dart';
import '../widgets/buttons/primary_button.dart';
import '../widgets/expanded_children_row.dart';
import '../widgets/innovay_text.dart';
import 'app_bar.dart';

class FileViewerPage extends StatefulWidget {
  final String title;
  final List<String> filePaths;

  const FileViewerPage({super.key, required this.title, required this.filePaths});

  @override
  State<StatefulWidget> createState() => _FileViewerPageState();
}

class _FileViewerPageState extends State<FileViewerPage> {
  String _pdfUrl = '';

  @override
  void initState() {
    super.initState();
    for (var item in widget.filePaths) {
      if (item.toLowerCase().endsWith('.pdf')) {
        _pdfUrl = item;
        break;
      }
    }
  }

  bool isWebFile(String url) {
    return url.toLowerCase().startsWith('http');
  }

  void onShareTap() async {
    var optionWidgets = <Widget>[];
    if (widget.filePaths.length > 1) {
      for (var i = 0; i < widget.filePaths.length; i++) {
        optionWidgets.add(
          InnovayBottomPickerActionButtonRow(
            widget.filePaths[i].split('/').last,
            InnoConfig.colors.textColor,
            () {
              _onTargetFileOptionTap(i);
            },
          ),
        );
      }
      CommonUtils.displayBottomPicker(context, '', optionWidgets);
      return;
    }
    _onTargetFileOptionTap(0);
  }

  void _onTargetFileOptionTap(int index) {
    var filePath = widget.filePaths[index];

    if (isWebFile(filePath)) {
      _displayShareOptions(filePath);
      return;
    }

    _uploadLocalFileAndDisplayShareOptions(filePath);
  }

  void _uploadLocalFileAndDisplayShareOptions(String filePath) async {
    final file = File(filePath);
    var bytes = await file.readAsBytes();
    var base64Encoded = base64.encode(bytes);

    InnoGlobalData.switchLoadingOverlay(true);
    var res = await NetworkManager.postRequestSync(
      InnoConfig.mainNetworkConfig.fileFullUpload(),
      dataLoad: {
        'filename': filePath.split('/').last,
        'base64EncodedFile': base64Encoded,
      },
    );

    InnoGlobalData.switchLoadingOverlay(false);
    _displayShareOptions(res['data']['url']);
  }

  void _displayShareOptions(String fileUrl) {
    final fileName = fileUrl.split('/').last;
    CommonUtils.displayShareOptions(fileUrl, fileName);
  }

  Widget createPdfViewerWidget() {
    if (_pdfUrl.isEmpty) {
      return const SizedBox.shrink();
    }

    DebugManager.error("Removed SfPdfViewer due to version conflicts");
    // if (isWebFile(_pdfUrl)) {
    //   return SfPdfViewer.network(_pdfUrl);
    // }
    // return SfPdfViewer.file(File(_pdfUrl));
    return const SizedBox.shrink();
  }

  Widget createUnrecognizedFileWidget() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ExpandedChildrenRow(children: [
        Image.asset('assets/innovay/FilePreviewIcon.png', width: 50, height: 50, fit: BoxFit.contain),
      ]),
      const SizedBox(height: 15),
      ExpandedChildrenRow(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InnoText(
            widget.filePaths[0].split('/').last,
            color: InnoConfig.colors.textColorLight7,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
        ),
      ]),
      const SizedBox(height: 15),
      ExpandedChildrenRow(children: [
        InnoText(
          AppLocalizations.of(context)!.previewUnavailablePleaseDownload,
          color: InnoConfig.colors.textColorLight7,
          fontSize: 14,
          textAlign: TextAlign.center,
          height: 1.5,
        )
      ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InnoAppBar(true, widget.title, []),
      backgroundColor: InnoConfig.colors.backgroundColor,
      body: SafeArea(
        child: Stack(children: [
          Column(children: [
            Expanded(child: _pdfUrl.isEmpty ? createUnrecognizedFileWidget() : createPdfViewerWidget()),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: InnovayPrimaryButton(AppLocalizations.of(context)!.shareFile, onShareTap),
                ),
              ]),
            ),
          ]),
        ]),
      ),
    );
  }
}
