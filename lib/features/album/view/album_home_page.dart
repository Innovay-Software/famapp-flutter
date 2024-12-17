import 'package:famapp/core/utils/dot_env_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/config.dart';
import '../../../core/global_data.dart';
import '../../../core/utils/baby_utils.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/datetime_util.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../core/utils/snack_bar_manager.dart';
import '../../../core/widgets/buttons/bottom_picker_action_button_row.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_ui_expanded_row.dart';
import '../../../core/widgets/innovay_text.dart';
import '../../../core/widgets/smart_refresher_footer.dart';
import '../../../core/widgets/smart_refresher_header.dart';
import '../../settings/viewmodel/user_viewmodel.dart';
import '../viewmodel/album_viewmodel.dart';
import '../viewmodel/enums/album_type.dart';
import 'album_list_page.dart';
import 'album_settings_page.dart';
import 'widgets/album_home_app_bar.dart';
import 'widgets/album_home_drawer.dart';
import 'widgets/album_home_editing_bar.dart';
import 'widgets/album_home_middle_avatar_section.dart';
import 'widgets/album_home_page_left_gradient.dart';
import 'widgets/album_home_page_right_gradient.dart';
import 'widgets/album_home_upload_background_button.dart';
import 'widgets/album_list_bar_widget.dart';
import 'widgets/album_media_row.dart';

class AlbumHomePage extends StatefulWidget {
  const AlbumHomePage({super.key});

  @override
  State<AlbumHomePage> createState() => _AlbumHomePageState();
}

class _AlbumHomePageState extends State<AlbumHomePage> with AutomaticKeepAliveClientMixin<AlbumHomePage> {
  final UserViewmodel _userViewmodel = UserViewmodel();
  final AlbumViewmodel _albumViewmodel = AlbumViewmodel();

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final ScrollController _listViewScrollController = ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
  final ScrollController _albumBarScrollController = ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
  DateTime _pivotDate = DateTime.now().toUtc();
  DateTime _currentDate = DateTime.now();

  double _mediaSize = 0;
  double _mediaRowHeight = 0;
  final double _topTextSectionHeight = 230;
  final double _topAvatarSectionHeight = 140;
  final double _topAlbumsBarHeight = 100;
  final double _stickyTopAlbumBarHeight = 140;

  final List<int> _selectedFileIds = [];

  bool _isEditingMode = false;
  bool _isReloading = false;
  bool _isLoadingMore = false;
  bool _showStickyAlbumBar = false;

  @override
  void initState() {
    super.initState();

    _setSystemUIMode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_albumViewmodel.currentAlbum != null && _albumViewmodel.currentAlbum!.files.isNotEmpty) {
        _addScrollControllerListeners();
      }

      InnoGlobalData.mediaFileBackgroundUploader.onAllFilesUploadedCallbacks.add(() {
        if (mounted) {
          _getAlbumFiles(forceReload: true, pivotDate: DateTime.now().toUtc());
        }
      });
    });
  }

  void _setSystemUIMode() {
    Future.delayed(const Duration(milliseconds: 500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      CommonUtils.setDarkStatusText();
    });
  }

  @override
  void dispose() {
    _listViewScrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _mediaSize = (MediaQuery.of(context).size.width - 36 * 2 - 20 * 2) / 3;
    _mediaRowHeight = _mediaSize + 20;
    var currentAlbum = context.watch<AlbumViewmodel>().currentAlbum;
    var allAlbums = context.watch<AlbumViewmodel>().albums;
    return Scaffold(
      // appBar: InnovayAppStatusBar(context, false, overrideBackgroundColor: Colors.transparent),
      // appBar: InnovayAppStatusBar(
      //   context,
      //   false,
      //   overrideBackgroundColor: const Color(0x01FFFFFF),
      // ),

      key: _drawerKey,
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      extendBody: true,
      bottomNavigationBar: AnimatedSlide(
        offset: _isEditingMode ? const Offset(0, -0.7) : const Offset(0, 1),
        duration: const Duration(milliseconds: 200),
        child: AlbumHomeEditingBar(
          onDeleteButtonTap: _onDeleteSelectedFilesTap,
          onSetCalendarDateTap: _onSetSelectedFilesCalendarDateTap,
          onMoveFilesTap: _onMoveSelectedFilesTap,
          onCancelTap: _onCancelEditingModeTap,
        ),
      ),
      body: Stack(
        children: [
          Column(children: [
            Image.asset(
              'assets/aurora/aurora_g1.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            // Expanded(
            //   child: Container(width: MediaQuery.of(context).size.width, color: InnovayConfig.colors.successColor),
            // ),
          ]),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.1),
          ),
          if (currentAlbum.isDummyAlbum())
            Padding(
              padding: const EdgeInsets.only(top: 500, left: 100, right: 100),
              child: ExpandedRowWidget(
                children: [
                  InnovayPrimaryButton(AppLocalizations.of(context)!.newAlbum, _onAlbumListTap),
                ],
              ),
            ),
          if (!currentAlbum.isDummyAlbum())
            SmartRefresher(
              enablePullDown: true,
              enablePullUp: currentAlbum.hasMore,
              header: InnovaySmartRefresherHeader(waterDropColor: InnoConfig.colors.primaryColorLighter),
              footer: const InnovaySmartRefresherFooter(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                // cacheExtent: 1000,
                padding: EdgeInsets.zero,
                controller: _listViewScrollController,
                // itemCount: 0,
                itemCount: currentAlbum.files.isEmpty ? 1 : (currentAlbum.files.length / 3).ceil(),
                itemBuilder: (BuildContext context, int index) {
                  var albumFiles = [
                    if (currentAlbum.files.length > index * 3) currentAlbum.files[index * 3],
                    if (currentAlbum.files.length > index * 3 + 1) currentAlbum.files[index * 3 + 1],
                    if (currentAlbum.files.length > index * 3 + 2) currentAlbum.files[index * 3 + 2],
                  ];
                  var albumFileIds = albumFiles.map((e) => e.id);

                  var mediaRow = AlbumMediaRow(
                    key: Key('AlbumMediaRow.${albumFileIds.join('-')}'),
                    startingAlbumFileIndex: index * 3,
                    rowHeight: _mediaRowHeight,
                    mediaCardSize: _mediaSize,
                    album: currentAlbum,
                    albumFiles: albumFiles,
                    editingSelectedIds: _selectedFileIds,
                    isEditingMode: _isEditingMode,
                    mediaFileProcessingMessage: AppLocalizations.of(context)!.mediaFileProcessing,
                    onMediaFileLongPressed: _onMediaFileLongPressed,
                    onMediaFileSelectStatusChanged: _onMediaSelectStatusChanged,
                    onNavigateBackToAlbumHome: _onNavigateBackToCurrentPage,
                  );

                  if (index == 0) {
                    return Column(children: [
                      SizedBox(
                        height: _topTextSectionHeight,
                        child: Column(
                          children: [
                            const SizedBox(height: 130),
                            InnoText(currentAlbum.title,
                                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                            if (kDebugMode)
                              InnoText(
                                'hasMore = ${currentAlbum.hasMore}, AID = ${currentAlbum.id}',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            const SizedBox(height: 10),
                            if (currentAlbum.albumType == AlbumType.baby)
                              InnoText(
                                [
                                  currentAlbum.metadata['name'],
                                  BabyUtils.getBabyAgeText(
                                    DateTime.tryParse('${currentAlbum.metadata['birthDate']}') ??
                                        DateTime.now().toLocal(),
                                    DateTime.now().toLocal(),
                                  ),
                                  AppLocalizations.of(context)!.albumFileCount(currentAlbum.totalFiles)
                                ].join(' · '),
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            if (currentAlbum.albumType == AlbumType.normal)
                              InnoText('${currentAlbum.totalFiles} Files', fontSize: 14, color: Colors.white),
                          ],
                        ),
                      ),
                      AlbumHomeMiddleAvatarSection(sectionHeight: _topAvatarSectionHeight, album: currentAlbum),
                      AlbumListBar(
                        scrollController: _albumBarScrollController,
                        height: _topAlbumsBarHeight,
                        albumCoverSize: 40,
                        paddingTop: 20,
                        onAlbumTap: _onAlbumTap,
                      ),
                      mediaRow,
                    ]);
                  }
                  if (index == (currentAlbum.files.length / 3).ceil() - 1) {
                    return Column(children: [
                      mediaRow,
                      ExpandedRowWidget(children: [
                        Container(color: InnoConfig.colors.backgroundColorTinted, height: 100),
                      ]),
                    ]);
                  }
                  return mediaRow;
                },
              ),
            ),
          if (_showStickyAlbumBar)
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              child: AlbumListBar(
                scrollController: _albumBarScrollController,
                height: _stickyTopAlbumBarHeight,
                paddingTop: 60,
                onAlbumTap: _onAlbumTap,
              ),
            ),
          if (_showStickyAlbumBar)
            Positioned(
              top: MediaQuery.of(context).padding.top + 115,
              left: 0,
              right: 0,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                InnoText(DatetimeUtils.formattedDate(_currentDate), color: InnoConfig.colors.textColorLight7)
              ]),
            ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AlbumHomeAppBar(
              height: 40,
              title: DotEnvField.APP_NAME.getDotEnvString('Famlinno'),
              onActionButtonTap: (index) {
                if (index == 0) {
                  _onAlbumSettingsTap();
                } else if (index == 1) {
                  _onCalendarTap();
                }
              },
            ),
          ),
          if (currentAlbum != null)
            Positioned.fill(
              // key: const Key('AlbumHomeUploadButton.parent'),
              child: AlbumHomeUploadBackgroundButton(
                key: const Key('AlbumHomeUploadButton'),
                albums: allAlbums,
                currentAlbum: currentAlbum,
                getCurrentAlbumId: _getCurrentAlbumId,
              ),
            ),
          const AlbumHomePageLeftGradient(),
          const AlbumHomePageRightGradient(),
          // Positioned(left: 50, top: 200, child: InnovayPrimaryButton('test', _test)),
        ],
      ),
      endDrawer: currentAlbum == null
          ? null
          : AlbumHomeDrawer(
              startingDate: currentAlbum.earliestFileDate.isEmpty
                  ? DateTime.now().add(const Duration(hours: 12))
                  : DateTime.parse(currentAlbum.earliestFileDate),
              onMonthSelected: (date) {
                currentAlbum.files.clear();
                setState(() {});
                var newDate = DateTime(date.year, date.month + 1, 1).subtract(const Duration(days: 1));
                _getAlbumFiles(pivotDate: newDate, forceReload: true);
                Navigator.pop(context);
              },
            ),
    );
  }

  void _onRefresh() async {
    DebugManager.log("_onRefresh");
    await _getAlbumFiles(forceReload: true, pivotDate: _pivotDate);
  }

  void _onLoading() async {
    DebugManager.log("_onLoading");
    await _getAlbumFiles(forceReload: false, pivotDate: _pivotDate);
  }

  void _onNavigateBackToCurrentPage() {
    DebugManager.log("AlbumHome._onNavigateBackToCurrentPage");
    Future.delayed(const Duration(milliseconds: 500), () {
      CommonUtils.setDarkStatusText();
    });
  }

  int _getCurrentAlbumId() {
    return _albumViewmodel.currentAlbum == null ? 0 : _albumViewmodel.currentAlbum!.id;
  }

  Future<void> _getAlbumFiles({required bool forceReload, DateTime? pivotDate}) async {
    if (_albumViewmodel.currentAlbum == null || _isReloading || _isLoadingMore) {
      return;
    }
    final currentAlbum = _albumViewmodel.currentAlbum!;

    pivotDate ??= DateTime.now().toUtc();
    _pivotDate = pivotDate;
    setState(() {});
    InnoGlobalData.switchLoadingOverlay(true);
    final isSuccessful = await _albumViewmodel.loadFiles(
      album: currentAlbum,
      forceReload: forceReload,
      pivotDate: pivotDate,
      startCallback: () {
        if (forceReload) {
          _isReloading = true;
        } else {
          _isLoadingMore = true;
        }
      },
    );
    InnoGlobalData.switchLoadingOverlay(false);
    if (!mounted) {
      return;
    }
    if (!isSuccessful) {
      _isReloading = false;
      _isLoadingMore = false;
      _refreshController.refreshFailed();
      _refreshController.loadFailed();
      return;
    }

    if (forceReload && _listViewScrollController.hasClients) {
      _listViewScrollController.jumpTo(0.0);
    }
    // _refreshController.position!.jumpTo(0.0);

    if (forceReload) {
      DebugManager.error("album.view.album_home Needs Implementation to make backup");
      // makeBackup
    }

    _isReloading = false;
    _isLoadingMore = false;
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  void _addScrollControllerListeners() {
    _listViewScrollController.addListener(() {
      var totalMediaRows = (_albumViewmodel.currentAlbum!.files.length / 3).ceil();
      var totalHeight = _topTextSectionHeight + _topAvatarSectionHeight - _stickyTopAlbumBarHeight;
      // DebugManager.log('offset = ${_scrollController.offset} + $totalMediaRows');
      for (var i = 0; i < totalMediaRows; i++) {
        totalHeight += _mediaRowHeight;
        if (totalHeight > _listViewScrollController.offset) {
          // DebugManager.log('hit: ${_albumViewmodel.currentAlbum!.listViewFiles[i][0].createdAt}');
          if (_albumViewmodel.currentAlbum!.files[i * 3].shotAt != _currentDate) {
            _currentDate = _albumViewmodel.currentAlbum!.files[i * 3].shotAt;
            // DebugManager.log("_addScrollControllerListeners setstate");
            setState(() {});
          }
          break;
        }
      }
      var shouldShowStickyAlbumBar = _listViewScrollController.offset > 276;
      if (shouldShowStickyAlbumBar != _showStickyAlbumBar) {
        _showStickyAlbumBar = shouldShowStickyAlbumBar;
        DebugManager.log("_addScrollControllerListeners set state");
        setState(() {});
      }
    });
  }

  void _onAlbumSettingsTap() async {
    if (_albumViewmodel.currentAlbum!.ownerId != _userViewmodel.currentUser.id &&
        !_userViewmodel.currentUser.isAdmin()) {
      return SnackBarManager.displayPermissionDeniedMessage();
    }
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlbumSettingsPage(album: _albumViewmodel.currentAlbum!)),
    );
  }

  void _onCalendarTap() {
    DebugManager.log("onSettingsButtonTap");
    _drawerKey.currentState!.openEndDrawer();
  }

  void _onMediaFileLongPressed(int fileId) {
    if (!_selectedFileIds.contains(fileId)) {
      _selectedFileIds.add(fileId);
    }
    _isEditingMode = true;
    setState(() {});
  }

  void _onMediaSelectStatusChanged(int fileId, bool shouldBeSelected) {
    if (_selectedFileIds.contains(fileId) && !shouldBeSelected) {
      _selectedFileIds.remove(fileId);
    } else if (!_selectedFileIds.contains(fileId) && shouldBeSelected) {
      _selectedFileIds.add(fileId);
    }
    setState(() {});
  }

  void _onAlbumTap(int albumId) {
    if (albumId <= 0) {
      return _onAlbumListTap();
    }
    if (_albumViewmodel.currentAlbum!.id == albumId) {
      return;
    }
    _albumViewmodel.setCurrentAlbum(albumId);
    if (_albumViewmodel.currentAlbum!.files.isEmpty) {
      _getAlbumFiles(forceReload: true, pivotDate: DateTime.now().add(const Duration(days: 1)));
    }
    _refreshController.position!.jumpTo(0.0);
    // _scrollController.jumpTo(0.0);
    setState(() {});
  }

  void _onDeleteSelectedFilesTap() {
    if (_selectedFileIds.isEmpty) return;
    final currentAlbum = _albumViewmodel.currentAlbum!;
    CommonUtils.displayCustomDialog(
      context,
      'Delete ${_selectedFileIds.length} files?',
      [],
      Icon(Icons.cancel_outlined, color: InnoConfig.colors.textColorLight7),
      Icon(CupertinoIcons.delete, color: InnoConfig.colors.deleteColor),
      null,
      () async {
        InnoGlobalData.switchLoadingOverlay(true);
        final isSuccessful = await AlbumViewmodel().deleteFiles(album: currentAlbum, albumFileIds: _selectedFileIds);
        InnoGlobalData.switchLoadingOverlay(false);
        if (isSuccessful && mounted) {
          _onCancelEditingModeTap();
        }
        setState(() {});
      },
      () => null,
      true,
    );
  }

  void _onSetSelectedFilesCalendarDateTap() async {
    if (_selectedFileIds.isEmpty) return;

    var now = DateTime.now();
    Pickers.showDatePicker(
      context,
      mode: DateMode.YMD,
      selectDate: PDuration(year: now.year, month: now.month, day: now.day),
      onConfirm: (datetime) async {
        DebugManager.unimplemented();
        InnoGlobalData.switchLoadingOverlay(true);
        final isSuccessful = await _albumViewmodel.setShotAtDate(
          _selectedFileIds,
          DateTime(datetime.year!, datetime.month!, datetime.day!),
        );
        InnoGlobalData.switchLoadingOverlay(false);

        if (isSuccessful && mounted) {
          _getAlbumFiles(forceReload: true, pivotDate: _pivotDate);
          _onCancelEditingModeTap();
        }
        setState(() {});
      },
    );
  }

  void _onMoveSelectedFilesTap() {
    final albums = _albumViewmodel.getAllAlbums();
    final currentAlbum = _albumViewmodel.currentAlbum!;
    CommonUtils.displayBottomPicker(
      context,
      '',
      albums.map((item) {
        return Builder(builder: (BuildContext context) {
          return InnovayBottomPickerActionButtonRow(item.title, InnoConfig.colors.textColor, () async {
            InnoGlobalData.switchLoadingOverlay(true);
            final isSuccessful = await AlbumViewmodel().moveToNewAlbum(
              oldAlbum: currentAlbum,
              newAlbum: item,
              albumFileIds: _selectedFileIds,
            );
            InnoGlobalData.switchLoadingOverlay(false);
            if (isSuccessful && mounted) {
              _getAlbumFiles(forceReload: true, pivotDate: _pivotDate);
              _onCancelEditingModeTap();
            }
            setState(() {});
          });
        });
      }).toList(),
    );
  }

  void _onCancelEditingModeTap() {
    _selectedFileIds.clear();
    _isEditingMode = false;
    setState(() {});
  }

  void _onAlbumListTap() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AlbumListPage()),
    );
    _onNavigateBackToCurrentPage();
    setState(() {});
  }
}
