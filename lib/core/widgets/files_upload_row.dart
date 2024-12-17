import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../models/inno_file_upload_item.dart';
import '../utils/common_utils.dart';
import '../utils/file_utils.dart';
import '../utils/snack_bar_manager.dart';
import '../views/file_viewer.dart';
import 'buttons/delete_button.dart';
import 'buttons/text_button.dart';
import 'expanded_children_row.dart';

class InnovayFileUploadRow extends StatefulWidget {
  final int maxFileCount;
  final List<String> initialUploadedUrls;
  final Function(List<InnoFileUploadItem>) onFileListChanged;

  const InnovayFileUploadRow({
    super.key,
    required this.maxFileCount,
    required this.initialUploadedUrls,
    required this.onFileListChanged,
  });

  @override
  State<InnovayFileUploadRow> createState() => InnovayFileUploadRowState();
}

class InnovayFileUploadRowState extends State<InnovayFileUploadRow> {
  final List<InnoFileUploadItem> _fileUploadItems = [];

  @override
  void initState() {
    super.initState();
    for (var item in widget.initialUploadedUrls) {
      _fileUploadItems.add(InnoFileUploadItem('', item, false, true, DateTime.now()));
    }
  }

  void onFileTap(int index) async {
    var fileUrl = _fileUploadItems[index].remoteUrl;
    // DebugManager.Log(_filelist[index]['url']);
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FileViewerPage(title: '', filePaths: [fileUrl])));
  }

  List<Widget> buildFileList() {
    List<Widget> widgetList = [];
    for (var i = 0; i < _fileUploadItems.length; i++) {
      var item = _fileUploadItems[i];
      var fileName = item.getFileName();
      bool isUploaded = item.isUploaded;
      widgetList.add(
          Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        InnovayTextButton('${i + 1}.$fileName', () {
          onFileTap(i);
        }),
        const SizedBox(width: 10),
        isUploaded
            ? InnovayDeleteButton('Delete', () {
                var index = i;
                onDeleteButtonTap(_fileUploadItems[i]);
              }, fontSize: 12)
            : Text('Uploading...', style: TextStyle(color: InnoConfig.colors.textColorLight7)),
        Expanded(child: Container(height: 1)),
      ]));
    }
    if (_fileUploadItems.length < widget.maxFileCount) {
      widgetList.add(InnovayTextButton('Add File', onAddFileTap, fontSize: 14));
    }
    return widgetList;
  }

  void onAddFileTap() {
    FileUtils.pickFiles(widget.maxFileCount, (pickedImageList) {
      _fileUploadItems.addAll(pickedImageList);
      uploadFiles();
    });
  }

  void uploadFiles() {
    for (var item in _fileUploadItems) {
      if (item.isUploaded) continue;
      if (item.isUploading) return;
      item.uploadToCloud((document) {
        final fileUrl = document['fileUrl'];
        widget.onFileListChanged(_fileUploadItems);
        setState(() {});
        uploadFiles();
      }, progressCallback: (progress) {}, useChunkUpload: false);
      return;
    }
    SnackBarManager.displayAllFilesUploadedMessage();
  }

  void onDeleteButtonTap(InnoFileUploadItem item) {
    CommonUtils.displayCustomDialog(
        context, 'Delete file?', [], const Icon(Icons.cancel_outlined), const Icon(CupertinoIcons.delete), null, () {
      setState(() {
        _fileUploadItems.remove(item);
        widget.onFileListChanged(_fileUploadItems);
      });
    }, () => null, true);
  }

  @override
  Widget build(BuildContext context) {
    return ExpandedChildrenRow(children: [
      Container(
          color: InnoConfig.colors.backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: buildFileList(),
          ))
    ]);
  }
}
