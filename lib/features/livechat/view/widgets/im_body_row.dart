import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/config.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../model/livechat_group.dart';
import '../../model/livechat_message.dart';
import 'im_card.dart';

class ImBodyRow extends StatelessWidget {
  final bool isEditingMode;
  final bool isSelected;
  final double contentMaxWidth;
  final LivechatGroupModel livechatGroup;
  final LivechatMessageModel livechatMessage;
  final AudioPlayer audioPlayer;
  final Function() onStartVoiceCallTap;
  final Function(String) onLongPress;
  final Function(String) onEditingTap;

  const ImBodyRow({
    super.key,
    required this.isEditingMode,
    required this.isSelected,
    required this.contentMaxWidth,
    required this.livechatGroup,
    required this.livechatMessage,
    required this.audioPlayer,
    required this.onStartVoiceCallTap,
    required this.onLongPress,
    required this.onEditingTap,
  });

  void _onMessageTap() {
    if (livechatMessage.type == ImMessageType.voiceCallInvitation) {
      onStartVoiceCallTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (['systemText', 'voiceCallCancellation', 'voiceCallRejection'].contains(livechatMessage.type)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            InnoText(livechatMessage.content, color: InnoConfig.colors.textColorLight7, fontSize: 12),
            const SizedBox(height: 5),
            InnoText(DateFormat.Hm().format(livechatMessage.createdAt),
                color: InnoConfig.colors.textColorLight7, fontSize: 8),
            const SizedBox(height: 20),
          ])
        ],
      );
    }

    return Stack(children: [
      if (isEditingMode)
        Positioned.fill(
          child: InkWell(
            onTap: () {
              onEditingTap(livechatMessage.id);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: isSelected
                      ? const Icon(Icons.check_box_rounded)
                      : const Icon(Icons.check_box_outline_blank_rounded),
                ),
              ],
            ),
          ),
        ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (isEditingMode) const SizedBox(width: 40),
          if (livechatMessage.isOwner()) const Spacer(),
          if (!livechatMessage.isOwner())
            Padding(
              padding: const EdgeInsets.all(5),
              child: InnoAvatarUserId(
                0,
                overrideUrl: livechatGroup.getMemberAvatar(livechatMessage.owner),
                userName: livechatGroup.getMemberAvatar(livechatMessage.owner),
                size: 38,
                borderRadius: 4,
              ),
            ),
          if (livechatMessage.isOwner() && livechatMessage.isLocalMessage)
            const SizedBox(height: 50, child: Center(child: CupertinoActivityIndicator())),
          Column(
            crossAxisAlignment: livechatMessage.isOwner() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              ImCard(
                maxWidth: MediaQuery.of(context).size.width * 0.5,
                livechatGroup: livechatGroup,
                livechatMessage: livechatMessage,
                audioPlayer: audioPlayer,
                onTap: _onMessageTap,
                onLongPress: onLongPress,
              ),
              if (!livechatMessage.isLocalMessage)
                InnoText(
                  '   ${DateFormat.Hm().format(livechatMessage.createdAt.toLocal())}   ',
                  fontSize: 8,
                  color: InnoConfig.colors.textColorLight7,
                ),
              if (kDebugMode) InnoText(livechatMessage.type, fontSize: 12),
            ],
          ),
          if (!livechatMessage.isOwner() && livechatMessage.isLocalMessage)
            const SizedBox(height: 50, child: Center(child: CupertinoActivityIndicator())),
          if (livechatMessage.isOwner())
            Padding(
              padding: const EdgeInsets.all(5),
              child: InnoAvatarUserId(
                0,
                overrideUrl: livechatGroup.getMemberAvatar(livechatMessage.owner),
                userName: livechatGroup.getMemberAvatar(livechatMessage.owner),
                size: 38,
                borderRadius: 4,
              ),
            ),
          // const SizedBox(width: 15),
        ],
      ),
    ]);
  }
}
