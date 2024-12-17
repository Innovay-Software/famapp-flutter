import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../../core/config.dart';
import '../../../../core/utils/debug_utils.dart';
import '../../../../core/utils/snack_bar_manager.dart';
import '../../../../core/widgets/buttons/background_button.dart';
import 'standby_audio_wave.dart';

class ImAudioRecordPanel extends StatefulWidget {
  final Function() onExitButtonTap;
  final Function() onImageButtonTap;
  final Function() onMoreButtonTap;
  final Function(String) onSendAudioTap;

  const ImAudioRecordPanel({
    super.key,
    required this.onExitButtonTap,
    required this.onImageButtonTap,
    required this.onMoreButtonTap,
    required this.onSendAudioTap,
  });

  @override
  State<ImAudioRecordPanel> createState() => _ImAudioRecordPanelState();
}

class _ImAudioRecordPanelState extends State<ImAudioRecordPanel> with SingleTickerProviderStateMixin {
  late String _documentsDirectory;
  final AudioRecorder _audioRecorder = AudioRecorder();
  late String _mainAudioFilePath;

  final RecordConfig _audioRecorderConfig = const RecordConfig(
    encoder: AudioEncoder.aacLc,
    bitRate: 128000,
    sampleRate: 44100,
    numChannels: 1,
  );

  final GlobalKey _pauseButtonGlobalKey = GlobalKey();
  final GlobalKey _sendButtonGlobalKey = GlobalKey();
  final List<double> _pauseButtonCoordinate = [0, 0];
  final double _pauseButtonSize = 60;
  final List<double> _sendButtonCoordinate = [0, 0];
  final double _sendButtonSize = 60;
  AudioPlayer? _audioPlayer;
  int _audioRecordingIndex = 0;
  double _panelHeight = 170;
  bool _isRecording = false;
  bool _isMergeAudioRecordingFile = false;
  bool _isHoveringPause = false;
  bool _isHoveringSend = false;
  bool _canRecordAudio = true;
  double _audioPlayerProgress = 0;

  @override
  void initState() {
    super.initState();
    _audioRecorder.onAmplitudeChanged(const Duration(seconds: 1)).listen((event) {
      DebugManager.log("OnAmplitudeChanged: ${event.current}");
    });
    // _getAudioFilePath();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      RenderBox boxPause = _pauseButtonGlobalKey.currentContext!.findRenderObject() as RenderBox;
      Offset positionPause = boxPause.localToGlobal(Offset.zero); //this is global position
      _pauseButtonCoordinate[0] = positionPause.dx + _pauseButtonSize / 2;
      _pauseButtonCoordinate[1] = positionPause.dy + _pauseButtonSize / 2;
      RenderBox boxPauseSend = _sendButtonGlobalKey.currentContext!.findRenderObject() as RenderBox;
      Offset positionSend = boxPauseSend.localToGlobal(Offset.zero); //this is global position
      _sendButtonCoordinate[0] = positionSend.dx + _sendButtonSize / 2;
      _sendButtonCoordinate[1] = positionSend.dy + _sendButtonSize / 2;

      _documentsDirectory = (await getApplicationDocumentsDirectory()).path;
      _mainAudioFilePath = "$_documentsDirectory/AudioRecording.m4a";
      DebugManager.log("audioFilePath = $_mainAudioFilePath");
    });
  }
  //
  // void _getAudioFilePath() async {
  // }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    _audioRecorder.dispose();
    var file = File(_mainAudioFilePath);
    if (file.existsSync()) {
      file.delete();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _panelHeight,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      child: Stack(
        children: [
          CustomPaint(
              painter: ImAudioRecordPanelTopBorderPainter(
                backgroundColors: _isRecording
                    ? [
                        InnoConfig.colors.primaryColorLighter.withOpacity(.1),
                        InnoConfig.colors.backgroundColor,
                      ]
                    : [
                        InnoConfig.colors.backgroundColorTinted,
                        InnoConfig.colors.backgroundColor,
                      ],
              ),
              child: SizedBox(width: MediaQuery.of(context).size.width, height: _panelHeight)),
          Column(children: [
            AnimatedOpacity(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 200),
              opacity: _isRecording || _audioPlayer != null ? 1 : 0,
              child: AnimatedContainer(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 100),
                width: _isRecording ? 120 : 180,
                height: _isRecording
                    ? 60
                    : _audioPlayer == null
                        ? 60
                        : 100,
                margin: EdgeInsets.only(top: _isRecording ? 60 : 40),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: InnoConfig.colors.primaryColorLighter,
                ),
                child: _isRecording
                    ? Stack(clipBehavior: Clip.none, children: [
                        StandbyAudioWave(color: InnoConfig.colors.backgroundColor),
                        // Positioned(
                        //   bottom: -42,
                        //   left: 20,
                        //   child: Icon(
                        //     Icons.arrow_drop_down_rounded,
                        //     color: InnovayConfig.colors.primaryColorLighter,
                        //     size: 60,
                        //   ),
                        // ),
                      ])
                    : _audioPlayer == null
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: _onRecordedAudioTap,
                            child: Container(
                              color: Colors.white.withOpacity(.01),
                              padding: const EdgeInsets.only(bottom: 30),
                              child: _isMergeAudioRecordingFile
                                  ? const CupertinoActivityIndicator()
                                  : Center(
                                      child: _audioPlayer!.playing
                                          ? const Icon(Icons.pause_circle, color: Colors.white, size: 32)
                                          : const Icon(Icons.play_circle, color: Colors.white, size: 32),
                                    ),
                            ),
                          ),
              ),
            ),
            const Spacer(),
            // InnovayText('00:30 / 01:00'),
            // IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.mic_circle_fill, size: 80)),
            Container(
              height: 70,
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                InnovayBackgroundButton(
                  '',
                  InnoConfig.colors.textColorLight4,
                  widget.onExitButtonTap,
                  backgroundColor: _isRecording
                      ? InnoConfig.colors.primaryColorLighter.withOpacity(.3)
                      : InnoConfig.colors.backgroundColor,
                  prefixWidget: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) => const LinearGradient(
                      // center: Alignment.topCenter,
                      begin: Alignment(-1, -1),
                      end: Alignment(1, 1),
                      stops: [.3, 1],
                      colors: [
                        Color(0xFF4158D0),
                        Color(0xFFC850C0),
                        // Color(0xFF667EEA),
                        // Color(0xFF764BA2),
                      ],
                    ).createShader(bounds),
                    child: const Icon(CupertinoIcons.keyboard_chevron_compact_down, size: 24),
                  ),
                  hExtraPadding: 5,
                  vExtraPadding: 5,
                ),
                const SizedBox(width: 5),
                InnovayBackgroundButton(
                  '',
                  InnoConfig.colors.textColorLight4,
                  widget.onImageButtonTap,
                  backgroundColor: _isRecording
                      ? InnoConfig.colors.primaryColorLighter.withOpacity(.3)
                      : InnoConfig.colors.backgroundColor,
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
                // const SizedBox(width: 5),
                const Spacer(),
                // const SizedBox(width: 5),
                InnovayBackgroundButton(
                  '',
                  InnoConfig.colors.primaryColor,
                  widget.onMoreButtonTap,
                  backgroundColor: _isRecording
                      ? InnoConfig.colors.primaryColorLighter.withOpacity(.3)
                      : InnoConfig.colors.backgroundColor,
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
          ]),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 40),
                AnimatedOpacity(
                  opacity: _isRecording ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 90),
                    child: Container(
                      key: _pauseButtonGlobalKey,
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: _isHoveringPause ? const Color(0xFF4158D0) : Colors.transparent,
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(color: const Color(0xFF4158D0), width: 2)),
                      child: Center(
                        child: Icon(
                          Icons.pause,
                          size: 32,
                          color: _isHoveringPause ? Colors.white : const Color(0xFF4158D0),
                        ),
                      ),
                    ),
                  ),
                ),
                Listener(
                  onPointerDown: _onRecordPointerDown,
                  onPointerUp: _onRecordPointerUp,
                  onPointerMove: _onRecordPointerMove,
                  child: _isRecording
                      ? Icon(CupertinoIcons.mic_circle_fill, size: 80, color: InnoConfig.colors.primaryColor)
                      : ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) => const LinearGradient(
                            // center: Alignment.topCenter,
                            begin: Alignment(-1, -1),
                            end: Alignment(1, 1),
                            stops: [.3, 1],
                            colors: [
                              Color(0xFF4158D0),
                              Color(0xFFC850C0),
                              // Color(0xFF667EEA),
                              // Color(0xFF764BA2),
                            ],
                          ).createShader(bounds),
                          child: const Icon(CupertinoIcons.mic_circle_fill, size: 80),
                        ),
                ),
                AnimatedOpacity(
                  opacity: _isRecording ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 90),
                    child: Container(
                      key: _sendButtonGlobalKey,
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        color: _isHoveringSend ? const Color(0xFFC850C0) : Colors.transparent,
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(color: const Color(0xFFC850C0), width: 2),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.send_rounded,
                          size: 32,
                          color: _isHoveringSend ? Colors.white : const Color(0xFFC850C0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),
          if (_audioPlayer != null && _audioPlayer!.duration != null)
            Positioned(
              bottom: 110,
              left: (MediaQuery.of(context).size.width - 180) / 2,
              right: (MediaQuery.of(context).size.width - 180) / 2,
              child: AnimatedOpacity(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 200),
                opacity: _isRecording || _audioPlayer == null ? 0 : 1,
                child: CupertinoSlider(
                  value: _audioPlayerProgress,
                  onChanged: (double value) {
                    _audioPlayerProgress = value;
                    setState(() {});
                  },
                  onChangeStart: (double value) {
                    _audioPlayer?.pause();
                  },
                  onChangeEnd: (double value) {
                    var duration = Duration(milliseconds: value.floor());
                    _audioPlayer?.seek(duration);
                    _audioPlayer?.play();
                    setState(() {});
                  },
                  min: 0,
                  max: _audioPlayer!.duration!.inMilliseconds * 1.0,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onRecordPointerDown(PointerDownEvent pointerDownEvent) async {
    if (!_canRecordAudio) {
      return;
    }
    _audioPlayer?.pause();
    _canRecordAudio = false;

    _panelHeight = 300;
    _isRecording = true;
    setState(() {});

    await Future.delayed(const Duration(milliseconds: 200));

    // if (true || await _audioRecorder.hasPermission()) {

    // if still tapped down, start audio recorder
    if (_isRecording) {
      // Start recording to file
      _audioRecordingIndex += 1;
      var newAudioPath = "$_documentsDirectory/AudioRecording$_audioRecordingIndex.m4a";
      await _audioRecorder.start(_audioRecorderConfig, path: newAudioPath);
    }

    _canRecordAudio = true;
    // // ... or to stream
    // final stream = await _audioRecorder.startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
    // }
  }

  void _onRecordPointerUp(PointerUpEvent pointerUpEvent) async {
    DebugManager.log("_onRecordPointerUp");
    _isRecording = false;

    // Step1: stop audio recording and save it to file
    _audioRecorder.stop();
    final newlyRecordedAudioFilePath = "$_documentsDirectory/AudioRecording$_audioRecordingIndex.m4a";
    final newlyRecordedAudioFile = File(newlyRecordedAudioFilePath);
    final newlyRecordedAudioFileExists = newlyRecordedAudioFile.existsSync();
    var length = 0;
    if (newlyRecordedAudioFileExists) {
      length = await newlyRecordedAudioFile.length();
    }

    // Step2: if audio was too short, ignore it
    if (newlyRecordedAudioFilePath.isEmpty || !newlyRecordedAudioFileExists || length < 60000) {
      SnackBarManager.displayMessage('内容过短');
      final mainAudioFile = File(_mainAudioFilePath);
      _deleteAudioFile(newlyRecordedAudioFile);
      _deleteAudioFile(mainAudioFile);
      _onRecordPointerUpProcessed();
      _panelHeight = 170;
      _audioPlayer?.dispose();
      _audioPlayer = null;
      return;
    }
    DebugManager.log("haha5");

    // At this point, newlyRecordedAudioFile is guaranteed to exist

    // Step3: check if the main audio file exists
    final mainAudioFile = File(_mainAudioFilePath);
    final mainAudioFileExists = mainAudioFile.existsSync();

    if (!_isHoveringPause && !_isHoveringSend) {
      // Step4: if wasn't hovering pause button nor send button, cancel all recordings
      await _deleteAudioFile(newlyRecordedAudioFile);
      await _deleteAudioFile(mainAudioFile);
    } else {
      // Step5: was either hovering pause button or send button,
      // either way, we need to merge the new audio file to the main audio file
      if (mainAudioFileExists) {
        // Step5.1a: Merge if main audio file exists
        var mergeResult = await _mergeNewlyRecordedAudioFileToMainAudioFile(mainAudioFile, newlyRecordedAudioFile);
      } else {
        // Step5.1b: if main audio file doesn't exist, then rename newly created audio file to main audio file
        newlyRecordedAudioFile.renameSync(_mainAudioFilePath);
        // refresh _audioPlayer since audioFile has changed
      }

      if (_isHoveringSend) {
        var mainAudioFile = File(_mainAudioFilePath);
        var sendFileName = '$_mainAudioFilePath.${DateTime.now().toUtc().millisecondsSinceEpoch}.m4a';
        mainAudioFile.renameSync(sendFileName);
        widget.onSendAudioTap(sendFileName);

        DebugManager.log("Needs Implementation: send file");
      }
    }

    final mainAudioFile2 = File(_mainAudioFilePath);
    final mainAudioFile2Exists = mainAudioFile2.existsSync();

    _audioPlayer?.dispose();
    _audioPlayer = null;

    if (!mainAudioFile2Exists) {
      _panelHeight = 170;
    } else {
      _panelHeight = 250;
      await _initNewAudioPlayer();
    }

    _onRecordPointerUpProcessed();
  }

  void _onRecordPointerUpProcessed() {
    _isRecording = false;
    _isHoveringPause = false;
    _isHoveringSend = false;
    DebugManager.log("_onRecordPointerUpProcessed");
    setState(() {});
  }

  Future<void> _deleteAudioFile(File audioRecordFile) async {
    if (await audioRecordFile.exists()) {
      await audioRecordFile.delete();
    }
  }

  Future<bool> _mergeNewlyRecordedAudioFileToMainAudioFile(File mainAudioFile, File newlyRecordedAudioFile) async {
    _isMergeAudioRecordingFile = true;
    setState(() {});

    // Step5.1: rename main audio file
    var tempMainAudioFilePath = "$_mainAudioFilePath.temp.m4a";
    mainAudioFile.renameSync(tempMainAudioFilePath);
    var tempMainAudioFile = File(tempMainAudioFilePath);

    // Step5.2: do FFMpeg merge
    String inputs = "-i '${tempMainAudioFile.path}' -i '${newlyRecordedAudioFile.path}'";
    String concatFilter = "concat=n=2:v=0:a=1[aout]";
    String mapArgs = "-map [aout]";
    String command = "$inputs -filter_complex $concatFilter -threads 0 $mapArgs '$_mainAudioFilePath'";
    DebugManager.log("FFMpeg Merge Command: $command");
    var session = await FFmpegKit.execute(command);

    // Step3: check result
    var returnCode = await session.getReturnCode();
    if (returnCode != null && returnCode.isValueSuccess()) {
      // if result was successful, delete temp files, leave only the merge audioFile as _audioFilePath
      DebugManager.log("SUCCESS");
      newlyRecordedAudioFile.delete();
      tempMainAudioFile.delete();
    } else {
      // if result was unsuccessful, log output if possible
      DebugManager.error("FFMpeg ERROR");
      var output = await session.getOutput();
      DebugManager.log(output ?? 'No Output');
    }

    _isMergeAudioRecordingFile = false;
    setState(() {});

    return returnCode != null && returnCode.isValueSuccess();
  }

  Future<void> _initNewAudioPlayer() async {
    _audioPlayer?.dispose();
    _audioPlayer = AudioPlayer();
    await _audioPlayer!.setAudioSource(AudioSource.file(_mainAudioFilePath));
    await _audioPlayer!.setLoopMode(LoopMode.one);
    _audioPlayerProgress = 0;
    _audioPlayer!.createPositionStream().listen((event) {
      _audioPlayerProgress = event.inMilliseconds * 1.0;
      setState(() {});
    });
  }

  void _onRecordPointerMove(PointerMoveEvent pointerMoveEvent) {
    // DebugManager.log("PointerMoveEvent");
    var px = pointerMoveEvent.position.dx;
    var py = pointerMoveEvent.position.dy;
    var pauseX = _pauseButtonCoordinate[0];
    var pauseY = _pauseButtonCoordinate[1];
    var sendX = _sendButtonCoordinate[0];
    var sendY = _sendButtonCoordinate[1];
    var valPause = sqrt(pow(pauseX - px, 2) + pow(pauseY - py, 2)) < _pauseButtonSize / 2;
    var valSend = sqrt(pow(sendX - px, 2) + pow(sendY - py, 2)) < _sendButtonSize / 2;
    if (valPause != _isHoveringPause || valSend != _isHoveringSend) {
      _isHoveringPause = valPause;
      _isHoveringSend = valSend;
      setState(() {});
    }
  }

  void _onRecordedAudioTap() async {
    if (_isMergeAudioRecordingFile) {
      return;
    }
    DebugManager.log("_onRecordedAudioTap $_mainAudioFilePath");
    var file = File(_mainAudioFilePath);
    if (!file.existsSync()) {
      DebugManager.log("File not exist");
      return;
    } else {
      // DebugManager.log("File exist");
      // DebugManager.log("File length: ${file.lengthSync()}");
    }
    if (_audioPlayer!.playing) {
      DebugManager.log("Pause");
      _audioPlayer!.pause();
    } else {
      DebugManager.log("Play");
      _audioPlayer!.play();
    }
    setState(() {});
  }
}

class ImAudioRecordPanelTopBorderPainter extends CustomPainter {
  List<Color> backgroundColors;
  ImAudioRecordPanelTopBorderPainter({required this.backgroundColors});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = Colors.white.withOpacity(0.99);
    var initialOffsetY = 25.0;
    var borderWidth = 4.0;
    var radius = 800.0;
    var customPath1 = Path()
      ..moveTo(0, initialOffsetY)
      ..arcToPoint(Offset(size.width, initialOffsetY), radius: Radius.circular(radius))
      ..lineTo(size.width, initialOffsetY + borderWidth)
      ..arcToPoint(Offset(0, initialOffsetY + borderWidth), radius: Radius.circular(radius), clockwise: false);
    canvas.drawPath(customPath1, paint1);

    final paint2 = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.5, 0),
        Offset(size.width * 0.5, size.height),
        backgroundColors,
      );

    // ..color = InnovayConfig.colors.backgroundColorTinted3;
    var customPath2 = Path()
      ..moveTo(0, initialOffsetY + borderWidth)
      ..arcToPoint(Offset(size.width, initialOffsetY + borderWidth), radius: Radius.circular(radius))
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);
    canvas.drawPath(customPath2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
