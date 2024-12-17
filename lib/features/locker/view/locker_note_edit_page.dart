import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart';
// import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/config.dart';
import '../../../core/global_data.dart';
import '../../../core/models/inno_file_upload_item.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../core/utils/snack_bar_manager.dart';
import '../../../core/widgets/avatar.dart';
import '../../../core/widgets/innovay_text.dart';
import '../../settings/viewmodel/user_viewmodel.dart';
import '../model/locker_note_model.dart';
import '../viewmodel/locker_viewmodel.dart';
import 'locker_note_settings_page.dart';
import 'widgets/locker_note_edit_app_bar.dart';

class LockerNoteEditPage extends StatefulWidget {
  final LockerNote lockerNote;
  final bool readonly;

  const LockerNoteEditPage({
    super.key,
    required this.lockerNote,
    required this.readonly,
  });

  @override
  State<LockerNoteEditPage> createState() => _LockerNoteEditPageState();
}

class _LockerNoteEditPageState extends State<LockerNoteEditPage> {
  final LockerViewmodel _viewmodel = LockerViewmodel();
  final List<InnoFileUploadItem> _fileUploadModels = [];
  late QuillController _quillController;
  late QuillController _quillControllerReadonly;
  bool _isLoading = false;
  bool _readonly = false;

  final FocusNode _focusNode = FocusNode();
  Timer? _selectAllTimer;

  @override
  void initState() {
    super.initState();
    _readonly = widget.readonly;

    try {
      final contentJson = jsonDecode(widget.lockerNote.content);
      _quillController = QuillController(
        document: Document.fromJson(contentJson),
        selection: const TextSelection.collapsed(offset: 0),
      );
      _quillControllerReadonly = QuillController(
          document: Document.fromJson(contentJson),
          selection: const TextSelection.collapsed(offset: 0),
          readOnly: true);
    } catch (error) {
      DebugManager.log(error);
      _quillController = QuillController(
        document: Document()..insert(0, widget.lockerNote.content),
        selection: const TextSelection.collapsed(offset: 0),
      );
      _quillControllerReadonly = QuillController(
          document: Document()..insert(0, widget.lockerNote.content),
          selection: const TextSelection.collapsed(offset: 0),
          readOnly: true);
    }
  }

  @override
  void dispose() {
    _selectAllTimer?.cancel();
    super.dispose();
  }

  void _onEditTap() {
    final user = UserViewmodel().currentUser;
    if (widget.lockerNote.owner['id'] != user.id) {
      return SnackBarManager.displayPermissionDeniedMessage();
    }
    _readonly = false;
    setState(() {});
  }

  void _onSettingsTap() async {
    final user = UserViewmodel().currentUser;
    if (widget.lockerNote.owner['id'] != user.id) {
      return SnackBarManager.displayPermissionDeniedMessage();
    }
    var shouldPop = await Navigator.push(
          context,
          // DialogRoute(context: context, builder: builder)
          CupertinoPageRoute(
            builder: (context) => LockerNoteSettingsPage(
              lockerNote: widget.lockerNote,
            ),
            fullscreenDialog: true,
          ),
        ) ??
        false;
    if (!mounted) {
      return;
    }
    if (shouldPop) {
      Navigator.pop(context, true);
    } else {
      setState(() {});
    }
  }

  void _onSaveTap() {
    if (_fileUploadModels.isEmpty) {
      return _onSaveTapConfirm();
    }
    CommonUtils.displayCustomDialog(
      context,
      'Please wait until all files are uploaded.',
      [],
      const Icon(Icons.cancel_outlined),
      null,
      const Icon(Icons.check_circle_outline),
      () => null,
      _onSaveTapConfirm,
      true,
    );
  }

  void _onSaveTapConfirm() async {
    var plainText = _quillController.document.getPlainText(0, _quillController.document.length);

    if (widget.lockerNote.title.isEmpty) {
      widget.lockerNote.title = plainText.split('\n').first;
    }
    if (widget.lockerNote.title.isEmpty) {
      widget.lockerNote.title = AppLocalizations.of(context)!.newNote;
    }
    widget.lockerNote.content = jsonEncode(_quillController.document.toDelta().toJson());
    _readonly = true;

    setState(() {});
    if (_isLoading == true) return;
    _isLoading = true;
    InnoGlobalData.switchLoadingOverlay(true);
    if (await _viewmodel.saveLockerNote(lockerNote: widget.lockerNote)) {
      _quillControllerReadonly = QuillController(
        document: Document.fromJson(jsonDecode(widget.lockerNote.content)),
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: true,
      );
    }
    _isLoading = false;
    InnoGlobalData.switchLoadingOverlay(false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LockerNoteEditAppBar(
        readonly: _readonly,
        isLoading: _isLoading,
        lockerNote: widget.lockerNote,
        onEditTap: _onEditTap,
        onDeleteTap: () {},
        onSaveTap: _onSaveTap,
        onSettingsTap: _onSettingsTap,
      ),
      // buildAppBar(),
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      // drawer: Container(
      //   constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
      //   color: Colors.grey.shade800,
      //   child: _buildMenuBar(context),
      // ),
      body: Stack(children: [
        buildEditor(context),
        buildInviteeBar(),
        if (_fileUploadModels.isNotEmpty)
          Positioned(
            left: 10,
            top: 10,
            child: Column(
              children: _fileUploadModels.map((uploadItem) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Stack(children: [
                      Image.file(File(uploadItem.localPath), width: 40, height: 40, fit: BoxFit.cover),
                      Container(
                        width: 40,
                        height: 40,
                        color: Colors.black.withOpacity(0.4),
                        child: Center(
                          child: InnoText(
                            '${uploadItem.uploadProgress}%',
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              }).toList(),
            ),
          ),
        if (_fileUploadModels.isNotEmpty)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(bottom: 50),
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(15),
                  width: 150,
                  height: 180,
                  child: Column(children: [
                    Image.file(File(_fileUploadModels.first.localPath), width: 120, height: 120, fit: BoxFit.cover),
                    const SizedBox(height: 10),
                    InnoText('${AppLocalizations.of(context)!.uploading}${_fileUploadModels.first.uploadProgress}%'),
                  ]),
                ),
              ),
            ),
          ),
      ]),
    );
  }

  Widget buildEditor(BuildContext context) {
    Widget quillEditor = QuillEditor.basic(
      configurations: QuillEditorConfigurations(
          controller: (_readonly || _isLoading) ? _quillControllerReadonly : _quillController,
          scrollable: true,
          autoFocus: false,
          placeholder: AppLocalizations.of(context)!.pleaseEnterContent,
          enableSelectionToolbar: isMobile(supportWeb: false),
          expands: false,
          padding: EdgeInsets.zero,
          onImagePaste: _onImagePaste,
          showCursor: !(_readonly || _isLoading),
          customStyles: const DefaultStyles(
            placeHolder: DefaultTextBlockStyle(
                TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.15,
                  fontWeight: FontWeight.w300,
                ),
                VerticalSpacing(16, 0),
                VerticalSpacing(0, 0),
                null),
            h1: DefaultTextBlockStyle(
                TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  height: 1.15,
                  fontWeight: FontWeight.w300,
                ),
                VerticalSpacing(16, 0),
                VerticalSpacing(0, 0),
                null),
            sizeSmall: TextStyle(fontSize: 9),
          )),
      // controller: _quillController,
      scrollController: ScrollController(),
      focusNode: _focusNode,
      // onTapUp: (details, p1) {
      //   return _onTripleClickSelection();
      // },
      // embedBuilders: [...FlutterQuillEmbeds.builders(), NotesEmbedBuilder(addEditNote: _addEditNote)],
    );
    var toolbar = QuillToolbar.simple(
      configurations: QuillSimpleToolbarConfigurations(
          controller: _quillController,
          showAlignmentButtons: true,
          multiRowsDisplay: true,
          showDividers: false,
          showFontFamily: true,
          showFontSize: true,
          showBoldButton: true,
          showItalicButton: true,
          showSmallButton: false,
          showUnderLineButton: true,
          showStrikeThrough: true,
          showInlineCode: true,
          showColorButton: true,
          showBackgroundColorButton: true,
          showClearFormat: true,
          showLeftAlignment: true,
          showCenterAlignment: true,
          showRightAlignment: true,
          showJustifyAlignment: true,
          showHeaderStyle: true,
          showListNumbers: true,
          showListBullets: true,
          showListCheck: true,
          showCodeBlock: true,
          showQuote: true,
          showIndent: true,
          showLink: true,
          showUndo: true,
          showRedo: true,
          showDirection: false,
          showSearchButton: true,
          showSubscript: true,
          showSuperscript: true),
      // afterButtonPressed: _readonly || _isLoading ? null : _focusNode.requestFocus,
      // controller: _quillController,
      // embedButtons: FlutterQuillEmbeds.buttons(
      //   onImagePickCallback: _onImagePickCallback,
      //   onVideoPickCallback: _onVideoPickCallback,
      // ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const SizedBox(height: 1),
        Expanded(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 40, right: 30, top: 5),
            child: quillEditor,
          ),
        ),
        if (!(_readonly || _isLoading))
          Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
            child: toolbar,
          ),
      ],
    );
  }

  Widget buildInviteeBar() {
    var users = [widget.lockerNote.owner, ...widget.lockerNote.invitees];
    // DebugManager.log("Build Invitee Bar: ${users.length} ${users.first['id']}");

    return Positioned(
      left: 10,
      top: 5,
      child: Column(
        children: users.map((user) {
          return Padding(
            padding: const EdgeInsets.only(top: 2),
            child: InnoAvatarUserId(
              user['id'],
              userName: user['name'],
              size: 20,
              borderRadius: 30,
            ),
          );
        }).toList(),
      ),
    );
  }

  String _basename(String path) {
    return path.split('/').last;
  }

  void _replaceLocalImageWithRemoteUrl(String localImagePath, String remoteUrl) {
    DebugManager.log("_replaceLocalImageWithRemoteUrl $localImagePath $remoteUrl");
  }

  Future<String> _uploadFileToCloud(File file) async {
    var uploadItem = InnoFileUploadItem(file.path, '', false, false, DateTime.now());
    _fileUploadModels.add(uploadItem);
    uploadItem.uploadToCloud((document) {}, useChunkUpload: true, progressCallback: (progress) {
      setState(() {});
    });
    setState(() {});

    while (true) {
      if (uploadItem.isUploaded) {
        break;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
    _fileUploadModels.remove(uploadItem);
    _replaceLocalImageWithRemoteUrl(uploadItem.localPath, uploadItem.remoteUrl);
    setState(() {});

    return uploadItem.remoteUrl;
  }

  // Renders the image picked by imagePicker from local file storage
  // You can also upload the picked image to any server (eg : AWS s3
  // or Firebase) and then return the uploaded image URL.
  Future<String> _onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    // final appDocDir = await getApplicationCacheDirectory();
    // final copiedFile = await file.copy('${appDocDir.path}/${_basename(file.path)}');

    return _uploadFileToCloud(file);
  }

  // Renders the video picked by imagePicker from local file storage
  // You can also upload the picked video to any server (eg : AWS s3
  // or Firebase) and then return the uploaded video URL.
  Future<String> _onVideoPickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory

    return _uploadFileToCloud(file);
  }

  // ignore: unused_element
  // Future<MediaPickSetting?> _selectMediaPickSetting(BuildContext context) => showDialog<MediaPickSetting>(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //         contentPadding: EdgeInsets.zero,
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ExpandedRowWidget(children: [
  //               InnovayBackgroundButton(
  //                 '相册',
  //                 InnovayConfig.colors.textColor,
  //                 () => Navigator.pop(ctx, MediaPickSetting.Gallery),
  //                 prefixWidget: const Icon(Icons.collections_bookmark_outlined),
  //               )
  //             ]),
  //             ExpandedRowWidget(children: [
  //               InnovayBackgroundButton(
  //                 '链接',
  //                 InnovayConfig.colors.textColor,
  //                 () => Navigator.pop(ctx, MediaPickSetting.Link),
  //                 prefixWidget: const Icon(Icons.link),
  //               )
  //             ]),
  //           ],
  //         ),
  //       ),
  //     );
  //
  // // ignore: unused_element
  // Future<MediaPickSetting?> _selectCameraPickSetting(BuildContext context) => showDialog<MediaPickSetting>(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //         contentPadding: EdgeInsets.zero,
  //         backgroundColor: Colors.white,
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextButton.icon(
  //               icon: const Icon(Icons.camera),
  //               label: const Text('Capture a photo'),
  //               onPressed: () => Navigator.pop(ctx, MediaPickSetting.Camera),
  //             ),
  //             TextButton.icon(
  //               icon: const Icon(Icons.video_call),
  //               label: const Text('Capture a video'),
  //               onPressed: () => Navigator.pop(ctx, MediaPickSetting.Video),
  //             )
  //           ],
  //         ),
  //       ),
  //     );

  Future<String> _onImagePaste(Uint8List imageBytes) async {
    // Saves the image to applications directory
    final appDocDir = await getApplicationCacheDirectory();
    final file = await File('${appDocDir.path}/${_basename('${DateTime.now().millisecondsSinceEpoch}.png')}')
        .writeAsBytes(imageBytes, flush: true);

    return _uploadFileToCloud(file);
  }

  Future<void> _addEditNote(BuildContext context, {Document? document}) async {
    final isEditing = document != null;
    final quillEditorController = QuillController(
      document: document ?? Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: const EdgeInsets.only(left: 16, top: 8),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${isEditing ? 'Edit' : 'Add'} note'),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            )
          ],
        ),
        // content: QuillEditor.basic(
        //     // controller: quillEditorController,
        //     // readOnly: false,
        //     ),
      ),
    );

    if (quillEditorController.document.isEmpty()) return;

    final block = BlockEmbed.custom(
      NotesBlockEmbed.fromDocument(quillEditorController.document),
    );
    final controller = _quillController;
    final index = controller.selection.baseOffset;
    final length = controller.selection.extentOffset - index;

    if (isEditing) {
      final offset = getEmbedNode(controller, controller.selection.start).offset;
      controller.replaceText(offset, 1, block, TextSelection.collapsed(offset: offset));
    } else {
      controller.replaceText(index, length, block, null);
    }
  }
}

class NotesEmbedBuilder extends EmbedBuilder {
  NotesEmbedBuilder({required this.addEditNote});

  Future<void> Function(BuildContext context, {Document? document}) addEditNote;

  @override
  String get key => 'notes';

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final notes = NotesBlockEmbed(node.value.data).document;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Text(
          notes.toPlainText().replaceAll('\n', ' '),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        leading: const Icon(Icons.notes),
        onTap: () => addEditNote(context, document: notes),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}

class NotesBlockEmbed extends CustomBlockEmbed {
  const NotesBlockEmbed(String value) : super(noteType, value);
  static const String noteType = 'notes';
  static NotesBlockEmbed fromDocument(Document document) => NotesBlockEmbed(jsonEncode(document.toDelta().toJson()));
  Document get document => Document.fromJson(jsonDecode(data));
}
