import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/config.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/buttons/background_button.dart';
import '../../../core/widgets/no_content_placeholder_widget.dart';
import '../../../core/widgets/smart_refresher_footer.dart';
import '../../settings/viewmodel/user_viewmodel.dart';
import '../model/locker_note_model.dart';
import '../viewmodel/locker_viewmodel.dart';
import 'locker_note_edit_page.dart';
import 'widgets/locker_home_passcode_overlay.dart';
import 'widgets/locker_note_bar.dart';

class LockerHomePage extends StatefulWidget {
  final Function(Function()) setStateCallback;

  const LockerHomePage({super.key, required this.setStateCallback});

  @override
  State<LockerHomePage> createState() => _LockerHomePageState();
}

class _LockerHomePageState extends State<LockerHomePage> {
  final LockerViewmodel _viewmodel = LockerViewmodel();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _showPasscodeOverlay = true;

  @override
  void initState() {
    super.initState();
    widget.setStateCallback(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getNotes();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onRefresh() async {
    _getNotes();
  }

  void _getNotes() async {
    final success = await _viewmodel.getLockerNotes(page: 1, pageSize: 100);
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = UserViewmodel().currentUser;
    if (user.lockerPasscode.isNotEmpty && _showPasscodeOverlay) {
      return LockerHomePasscodeOverlayPage(
        onSuccessCallback: () {
          _showPasscodeOverlay = false;
          setState(() {});
        },
      );
    }
    return Scaffold(
      appBar: InnoAppBar(
        false,
        AppLocalizations.of(context)!.locker,
        [
          InnovayBackgroundButton(
            '',
            prefixWidget: const Icon(Icons.add),
            InnoConfig.colors.primaryColor,
            _onNewNoteTap,
          ),
        ],
        toolbarHeight: 50,
      ),
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const WaterDropHeader(),
        footer: const InnovaySmartRefresherFooter(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemBuilder: (c, i) {
            if (context.watch<LockerViewmodel>().lockerNotes.isEmpty) {
              return const Row(mainAxisAlignment: MainAxisAlignment.center, children: [InnoNoContentPlaceholder()]);
            }
            if (i == context.watch<LockerViewmodel>().lockerNotes.length) {
              return const SizedBox(height: 50);
            }
            return LockerNoteBar(
              lockerNote: context.watch<LockerViewmodel>().lockerNotes[i],
              onTap: () {
                _onEditNoteTap(Provider.of<LockerViewmodel>(context, listen: false).lockerNotes[i], true);
              },
            );
          },
          itemCount: context.watch<LockerViewmodel>().lockerNotes.length + 1,
        ),
      ),
    );
  }

  // void _onMenuTap() {
  //   CommonUtils.displayBottomPicker(context, '', [
  //     InnovayBottomPickerActionButtonRow(
  //       '下载所有文件',
  //       InnovayConfig.colors.textColor,
  //       _onDownloadAllFilesTap,
  //       prefixWidget: const Icon(Icons.download),
  //     ),
  //   ]);
  // }

  void _onNewNoteTap() {
    final user = UserViewmodel().currentUser;
    _onEditNoteTap(
      LockerNote.fromJson({
        'title': AppLocalizations.of(context)!.newNote,
        'owner': {'id': user.id, 'name': user.name}
      }),
      false,
    );
  }

  void _onEditNoteTap(LockerNote lockerNote, bool readonly) async {
    var shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LockerNoteEditPage(
          lockerNote: lockerNote,
          readonly: readonly,
        ),
      ),
    );
    if (shouldRefresh) {
      _getNotes();
    } else {
      setState(() {});
    }
  }
}
