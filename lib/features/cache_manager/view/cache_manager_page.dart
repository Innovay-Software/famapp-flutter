import 'package:famapp/core/utils/unit_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/config.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/buttons/background_button.dart';
import '../../../core/widgets/innovay_text.dart';
import '../viewmodel/cache_manager_viewmodel.dart';
import 'widgets/cache_manager_stats_bar.dart';

class CacheManagerPage extends StatefulWidget {
  const CacheManagerPage({super.key});

  @override
  State<CacheManagerPage> createState() => _CacheManagerPageState();
}

class _CacheManagerPageState extends State<CacheManagerPage> {
  final CacheManagerViewmodel _viewmodel = CacheManagerViewmodel();

  @override
  void initState() {
    super.initState();
    _calculateCacheSize();
  }

  @override
  void dispose() {
    DebugManager.log("_UserCenterPageState.dispose");
    super.dispose();
  }

  void _calculateCacheSize() async {
    await _viewmodel.getCacheStats();
  }

  String _getSizeString(double size) {
    return UnitUtils.formatByteLength(size.round());
  }

  @override
  Widget build(BuildContext context) {
    var cacheStats = context.watch<CacheManagerViewmodel>().cacheStats;
    return Scaffold(
      appBar: InnoAppBar(
        false,
        AppLocalizations.of(context)!.cache,
        [
          InnovayBackgroundButton(
            '',
            Colors.blue,
            _calculateCacheSize,
            prefixWidget: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Stack(children: [
                Center(
                  child: cacheStats.totalCacheSize == 0
                      ? LoadingAnimationWidget.discreteCircle(color: Colors.blue, size: 150)
                      : Container(
                          width: 169,
                          height: 169,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            border: Border.all(color: Colors.blue, width: 19),
                          ),
                        ),
                ),
                Center(child: InnoText(_getSizeString(cacheStats.totalCacheSize), fontWeight: FontWeight.bold)),
              ]),
            ),
            Divider(thickness: 10, color: InnoConfig.colors.greyColor),
            CacheManagerStatsBar(
              icon: Icon(CupertinoIcons.photo_on_rectangle, color: const Color(0xFF4158D0).withOpacity(.8)),
              title: AppLocalizations.of(context)!.medias,
              content: _getSizeString(cacheStats.mediaCacheSize),
              actionButton: InnovayBackgroundButton(
                '',
                InnoConfig.colors.deleteColor,
                _clearImageAndVideoCache,
                prefixWidget: const Icon(CupertinoIcons.delete_simple),
              ),
            ),
            CacheManagerStatsBar(
              icon: Icon(CupertinoIcons.chat_bubble_2, color: const Color(0xFFC850C0).withOpacity(.8), size: 26),
              title: AppLocalizations.of(context)!.chatHistory,
              content: _getSizeString(cacheStats.imDatabasesCacheSize),
            ),
            CacheManagerStatsBar(
              icon: Icon(Icons.file_copy_outlined, color: Colors.blue.withOpacity(.8), size: 24),
              title: AppLocalizations.of(context)!.others,
              content: _getSizeString(
                  cacheStats.totalCacheSize - cacheStats.mediaCacheSize - cacheStats.imDatabasesCacheSize),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _clearImageAndVideoCache() {
    CommonUtils.displayCustomDialog(
      context,
      '确定清除缓存吗？',
      [],
      Icon(Icons.cancel_outlined, color: InnoConfig.colors.textColorLight9),
      null,
      Icon(Icons.check_circle_outline, color: InnoConfig.colors.deleteColor),
      () => null,
      () async {
        await _viewmodel.clearImageAndVideoCache();
      },
      true,
    );
  }
}
