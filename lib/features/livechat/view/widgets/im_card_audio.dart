import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/utils/debug_utils.dart';
import '../../../../core/utils/snack_bar_manager.dart';
import '../../model/livechat_message.dart';
import 'standby_audio_wave.dart';

class ImCardAudio extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final LivechatMessageModel livechatMessage;
  final Function() onLongPress;

  const ImCardAudio({super.key, required this.livechatMessage, required this.onLongPress, required this.audioPlayer});

  @override
  State<ImCardAudio> createState() => _ImCardAudioState();
}

class _ImCardAudioState extends State<ImCardAudio> {
  String _localCachePath = '';
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // try {
    //   _audioPlayer.setUrl(widget.imMessage.body);
    // } catch (e, stacktrace) {
    //   DebugManager.log("Cannot play audio: ${widget.imMessage.body}");
    //   DebugManager.log(e.toString());
    //   _validAudio = false;
    //   if (mounted) {
    //     setState(() {});
    //   }
    // }

    _getLocalCache();
    // _audioPlayer.setLoopMode(LoopMode.one);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getLocalCache() async {
    var cacheManager = DefaultCacheManager();
    var file = await cacheManager.getSingleFile(widget.livechatMessage.content);
    if (file.existsSync()) {
      _localCachePath = file.path;
    } else {
      _localCachePath = '';
    }
  }

  void _onTap() async {
    final audioPlayer = widget.audioPlayer;
    if (audioPlayer.playing) {
      await audioPlayer.stop();
    }

    try {
      if (_localCachePath.isNotEmpty) {
        var duration = await audioPlayer.setFilePath(_localCachePath);
        if (duration == null) {
          SnackBarManager.displayMessage('无法播放语音');
          return;
        }
      } else {
        var duration = await audioPlayer.setUrl(widget.livechatMessage.content);
        if (duration == null) {
          SnackBarManager.displayMessage('无法播放语音');
          return;
        }
      }

      var duration = audioPlayer.duration!.inMilliseconds;
      var position = audioPlayer.position.inMilliseconds;
      if (position >= duration) {
        _playAudio(true);
      } else {
        _playAudio(false);
      }

      DebugManager.log("Set State");
      if (mounted) {
        setState(() {});
      }
    } catch (e, stacktract) {
      SnackBarManager.displayMessage('无法播放语音');
    }
  }

  void _playAudio(bool restart) async {
    DebugManager.log("_playAudio $restart $_localCachePath");
    final audioPlayer = widget.audioPlayer;

    _isPlaying = true;
    if (restart) {
      await audioPlayer.seek(Duration.zero);
    }
    await audioPlayer.play();
    if (mounted) {
      setState(() {});
    }
    await audioPlayer.stop();
    _isPlaying = false;
  }

  @override
  Widget build(BuildContext context) {
    var foregroundColor = const Color(0xFF191919);

    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: _onTap,
      onLongPress: widget.onLongPress,
      child: Center(
        child: _isPlaying
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: StandbyAudioWave(color: foregroundColor))
            : Icon(
                Icons.volume_up_outlined,
                color: foregroundColor,
                size: 20,
              ),
      ),
    );
  }
}
