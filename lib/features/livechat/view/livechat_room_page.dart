import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../../../core/config.dart';
import '../../../core/models/inno_file_upload_item.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../core/utils/file_utils.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/buttons/background_button.dart';
import '../../../core/widgets/innovay_text.dart';
import '../viewmodel/livechat_viewmodel.dart';
import 'livechat_room_settings_page.dart';
import 'widgets/im_audio_record_panel.dart';
import 'widgets/im_body_row.dart';
import 'widgets/im_chat_room_editing_bar.dart';

class LivechatRoomPage extends StatefulWidget {
  const LivechatRoomPage({super.key});

  @override
  State<LivechatRoomPage> createState() => _LivechatRoomPageState();
}

class _LivechatRoomPageState extends State<LivechatRoomPage> with WidgetsBindingObserver {
  final String _callbackKey = "_LiveChatRoomPageState";

  final ScrollController _scrollController = ScrollController();
  final Map<String, int> _selectedMessageIdsMap = {};
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _userInputs = '';
  bool _isRecordingMode = false;
  bool _isEditingMode = false;

  @override
  void initState() {
    super.initState();
    // Listen to phone behaviour change
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAsync();
    });

    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 10) {
    //     _imGroupViewmodel.getPreviousMessages();
    //   }
    // });
  }

  initAsync() async {
    if (LivechatViewmodel().currentLivechatGroup == null) {
      return;
    }

    final currentLivechatGroup = LivechatViewmodel().currentLivechatGroup!;
    if (currentLivechatGroup.isLocalGroup) {
      var livechatGroup = LivechatViewmodel().currentLivechatGroup!;
      var members = <String>[];
      for (final item in livechatGroup.members) {
        members.add(item.uuid);
      }
      LivechatViewmodel().grpcService.sendUserGeneralUpsertGroupRequest(
            "",
            livechatGroup.clientId,
            livechatGroup.title,
            livechatGroup.isGroupChat,
            members,
          );
    }

    // Adding callbacks
    currentLivechatGroup.widgetUpdateCallbacks[_callbackKey] = () => setState(() {});
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    var currentLivechatGroup = LivechatViewmodel().currentLivechatGroup!;
    currentLivechatGroup.widgetUpdateCallbacks.remove(_callbackKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.imGroup.id == 0) {
    //   return const InnoPageLoadingScaffoldWidget();
    // }
    final livechatGroup = context.watch<LivechatViewmodel>().currentLivechatGroup;
    if (livechatGroup == null) {
      return const SizedBox.shrink();
    }

    final livechatMessages = livechatGroup.messages;

    return Scaffold(
      appBar: InnoAppBar(
        false,
        livechatGroup.getLivechatTitle(),
        [
          InnovayBackgroundButton(
            '',
            InnoConfig.colors.textColor,
            _onSettingsTap,
            prefixWidget: const Icon(Icons.more_horiz_rounded),
          )
        ],
      ),
      backgroundColor: const Color(0xFFFFFFFF), // InnoConfig.colors.backgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              color: const Color(0xFFF1F1F1), // Colors.InnoConfig.colors.backgroundColorTinted3,
              child: Column(
                children: [
                  if (kDebugMode) InnoText('ID: ${livechatGroup.id}, Messages: ${livechatMessages.length}'),
                  Expanded(
                    child: Container(
                      // color: InnovayConfig.colors.backgroundColorTinted3,
                      child: GroupedListView<dynamic, DateTime>(
                        padding: const EdgeInsets.all(8),
                        reverse: true,
                        order: GroupedListOrder.DESC,
                        controller: _scrollController,
                        elements: livechatMessages,
                        groupBy: (message) => DateTime.parse(message.createdAt.toLocal().toString().substring(0, 10)),
                        groupHeaderBuilder: (message) => SizedBox(
                          height: 40,
                          child: Center(
                            child: Container(
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(4),
                              //   color: InnovayConfig.colors.greyColorTextColor,
                              // ),
                              padding: const EdgeInsets.all(5),
                              child: InnoText(
                                message.createdAt.toLocal().toString().substring(0, 10),
                                color: InnoConfig.colors.textColorLight7,
                              ),
                            ),
                          ),
                        ),
                        itemComparator: (item1, item2) => item1.createdAt.compareTo(item2.createdAt),
                        itemBuilder: (context, message) => ImBodyRow(
                          key: Key('message-${message.id}'),
                          isEditingMode: _isEditingMode,
                          isSelected: _selectedMessageIdsMap.containsKey(message.id),
                          contentMaxWidth: MediaQuery.of(context).size.width * 0.5,
                          livechatGroup: livechatGroup,
                          livechatMessage: message,
                          audioPlayer: _audioPlayer,
                          onStartVoiceCallTap: () => null,
                          onLongPress: _onMessageLongPress,
                          onEditingTap: _onEditingTap,
                        ),
                      ),
                    ),
                  ),
                  _isRecordingMode
                      ? ImAudioRecordPanel(
                          onExitButtonTap: () {
                            _isRecordingMode = false;
                            setState(() {});
                          },
                          onImageButtonTap: _onSendImageTap,
                          onMoreButtonTap: _onMoreMenuTap,
                          onSendAudioTap: _onSendAudioTap,
                        )
                      : Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          color: InnoConfig.colors.backgroundColor,
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                            // InnovayBackgroundButton(
                            //   '',
                            //   InnoConfig.colors.textColorLight4,
                            //   _onAudioTap,
                            //   prefixWidget: ShaderMask(
                            //     blendMode: BlendMode.srcIn,
                            //     shaderCallback: (Rect bounds) => const LinearGradient(
                            //       // center: Alignment.topCenter,
                            //       begin: Alignment(-1, -1),
                            //       end: Alignment(1, 1),
                            //       stops: [.3, 1],
                            //       colors: [
                            //         Color(0xFF4158D0),
                            //         Color(0xFFC850C0),
                            //         // Color(0xFF667EEA),
                            //         // Color(0xFF764BA2),
                            //       ],
                            //     ).createShader(bounds),
                            //     child: Icon(
                            //       _isRecordingMode
                            //           ? CupertinoIcons.keyboard_chevron_compact_down
                            //           : CupertinoIcons.mic_circle,
                            //       size: 24,
                            //     ),
                            //   ),
                            //   hExtraPadding: 5,
                            //   vExtraPadding: 5,
                            // ),
                            const SizedBox(width: 5),
                            InnovayBackgroundButton(
                              '',
                              InnoConfig.colors.textColorLight4,
                              _onSendImageTap,
                              prefixWidget: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) => const LinearGradient(
                                  // center: Alignment.topCenter,
                                  begin: Alignment(-1, -1),
                                  end: Alignment(1, 1),
                                  stops: [.3, 1],
                                  colors: [
                                    Color(0xFFC850C0),
                                    Color(0xFFFFCC70),
                                    // Color(0xFF667EEA),
                                    // Color(0xFF764BA2),
                                  ],
                                ).createShader(bounds),
                                child: const Icon(CupertinoIcons.photo_on_rectangle, size: 24),
                              ),
                              hExtraPadding: 5,
                              vExtraPadding: 5,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: InnoConfig.colors.backgroundColorTinted3,
                                ),
                                child: TextField(
                                  controller: TextEditingController.fromValue(
                                    TextEditingValue(
                                      text: _userInputs,
                                      selection: TextSelection.collapsed(offset: _userInputs.length),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.send,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(12),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: AppLocalizations.of(context)!.pleaseEnter,
                                    hintStyle: const TextStyle(fontSize: 14),
                                  ),
                                  style: const TextStyle(fontSize: 14),
                                  onChanged: (text) {
                                    _userInputs = text;
                                  },
                                  onSubmitted: (text) {
                                    _onSendTextTap();
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            InnovayBackgroundButton(
                              '',
                              InnoConfig.colors.primaryColor,
                              _onMoreMenuTap,
                              prefixWidget: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) => const LinearGradient(
                                  // center: Alignment.topCenter,
                                  begin: Alignment(-1, -1),
                                  end: Alignment(1, 1),
                                  stops: [.1, 1],
                                  colors: [
                                    Color(0xFF667EEA),
                                    Color(0xFF764BA2),
                                  ],
                                ).createShader(bounds),
                                child: const Icon(CupertinoIcons.add_circled, size: 24),
                              ),
                              hExtraPadding: 5,
                              vExtraPadding: 5,
                            )
                          ]),
                        ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: 0,
            right: 0,
            bottom: _isEditingMode ? 0 : -MediaQuery.of(context).padding.bottom - 70,
            child: AlbumImChatRoomEditingBar(
              onDeleteButtonTap: _onDeleteMessageTap,
              onSetCalendarDateTap: () {},
              onMoveFilesTap: () {},
              onCancelTap: () {
                _isEditingMode = false;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onSettingsTap() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivechatRoomSettingsPage(
          livechatGroup: LivechatViewmodel().currentLivechatGroup!,
          onLeaveImGroup: () {
            DebugManager.log("onLeaveImGroup");
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _onAudioTap() async {
    var permissionGranted = false;
    var status = await Permission.microphone.status;
    DebugManager.log("Status = ${status.toString()}");
    if (status.isGranted) {
      permissionGranted = true;
    } else if (status.isDenied) {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
      if ((await Permission.contacts.request()).isGranted) {
        // Either the permission was already granted before or the user just granted it.
        permissionGranted = true;
      }
      var audioRecorder = AudioRecorder();
      if (await audioRecorder.hasPermission()) {
        permissionGranted = true;
      }
    }
    if (!mounted) return;

    if (permissionGranted) {
      _isRecordingMode = true;
      setState(() {});
      return;
    } else {
      CommonUtils.displayCustomDialog(
        context,
        'Microphone Permission',
        [],
        const Icon(Icons.cancel_outlined, color: Colors.grey),
        null,
        Icon(CupertinoIcons.settings, color: InnoConfig.colors.primaryColor),
        () => null,
        () {
          openAppSettings();
        },
        true,
      );
    }
  }

  void _onSendAudioTap(String filePath) {
    var file = File(filePath);
    DebugManager.log("_onSendAudioTap: $filePath, ${file.lengthSync()}");

    var uploadItem = InnoFileUploadItem(filePath, '', false, false, DateTime.now().toUtc());
    DebugManager.log("Send Audio: ${uploadItem.localPath}");
    _sendMessage('audio', '', uploadItem);
  }

  void _onSendImageTap() {
    FileUtils.pickMediasFromGallery(9, maxWidth: 1080, maxHeight: 1080, (fileUploadItems) async {
      if (fileUploadItems.isEmpty) return;

      for (var uploadItem in fileUploadItems) {
        _userInputs = '';
        var fileName = uploadItem.getFileName();
        var extension = fileName.split('.').last.toLowerCase();
        DebugManager.log("Extension = $extension");
        var fileType = 'video';
        if (['jpeg', 'jpg', 'png', 'gif', 'avif', 'svg', 'webp'].contains(extension)) {
          fileType = 'image';
        }
        _sendMessage(fileType, '', uploadItem);
      }

      setState(() {});
    });
  }

  void _onSendTextTap() {
    if (_userInputs.isEmpty) {
      return;
    }
    _sendMessage('text', _userInputs, null);
    _userInputs = '';
  }

  void _onMoreMenuTap() {}

  void _sendMessage(String type, String body, InnoFileUploadItem? uploadItem) async {
    setState(() {
      _userInputs = "";
    });

    if (body.isNotEmpty) {
      LivechatViewmodel().grpcService.sendUserGeneralSendMessageRequest(
            LivechatViewmodel().currentLivechatGroup!.id,
            body,
            type,
          );
    }
    // var id = (_imGroupViewmodel.imMessages.isEmpty ? 1 : _imGroupViewmodel.imMessages.last.id) + 100;
    //
    // var newMessage = ImMessage.LivechatMessageModel(true, {
    //   'id': id,
    //   'im_group_id': widget.livechatGroup.id,
    //   'user_id': _userViewmodel.currentUser.id,
    //   'user_name': _userViewmodel.currentUser.name,
    //   'type': type,
    //   'body': body,
    //   'seen': false,
    //   'created_at': (DateTime.now().toUtc().millisecondsSinceEpoch / 1000).floor(),
    // });
    //
    // DebugManager.log("Send message: $body ${_userViewmodel.currentUser.id}");
    // if (uploadItem != null) {
    //   newMessage.setImageUploadItem(uploadItem);
    // }
    // await _imGroupViewmodel.sendImMessage(newMessage);
    // await _imGroupViewmodel.getLatestMessages();
  }

  void _onMessageLongPress(String messageId) {
    DebugManager.log("_onLongPress $messageId");
    _selectedMessageIdsMap.clear();
    _selectedMessageIdsMap[messageId] = 1;
    _isEditingMode = true;
    setState(() {});
  }

  void _onEditingTap(String messageId) {
    if (_isEditingMode) {
      if (_selectedMessageIdsMap.containsKey(messageId)) {
        _selectedMessageIdsMap.remove(messageId);
      } else {
        _selectedMessageIdsMap[messageId] = 1;
      }
      setState(() {});
    }
  }

  void _onDeleteMessageTap() async {
    DebugManager.unimplemented(message: "_OnDeleteMessageTap");
    // InnoGlobalData.switchLoadingOverlay(true);
    // var result = await _imGroupViewmodel.deleteImMessages(widget.livechatGroup, _selectedMessageIdsMap.keys.toList());
    // SnackBarManager.displayMessage(result ? '已成功删除' : '删除失败');
    // InnoGlobalData.switchLoadingOverlay(false);
    // if (result) {
    //   _isEditingMode = false;
    // }
    // if (mounted) {
    //   setState(() {});
    // }
  }
}
