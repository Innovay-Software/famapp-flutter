import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/config.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/buttons/background_button.dart';
import '../../../core/widgets/smart_refresher_footer.dart';
import '../model/member_model.dart';
import '../view/widgets/member_bar.dart';
import '../viewmodel/members_viewmodel.dart';
import 'member_detail_page.dart';

class MemberListPage extends StatefulWidget {
  const MemberListPage({super.key});

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  final MemberViewmodel _viewmodel = MemberViewmodel();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getMembers();
    });
  }

  void _onRefresh() async {
    _getMembers();
  }

  void _getMembers() {
    final success = _viewmodel.getMembers();
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InnoAppBar(false, AppLocalizations.of(context)!.members, [
        InnovayBackgroundButton('', InnoConfig.colors.primaryColor, _addUser, prefixWidget: const Icon(Icons.add)),
      ]),
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const WaterDropHeader(),
        footer: const InnovaySmartRefresherFooter(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: context.watch<MemberViewmodel>().members.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < context.watch<MemberViewmodel>().members.length) {
              return MemberBar(member: context.watch<MemberViewmodel>().members[index]);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _addUser() {
    return _editUser(Member.fromJson({}));
  }

  void _editUser(Member member) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemberDetailPage(
          pageTitle: AppLocalizations.of(context)!.newMember,
          member: member,
          // onDeleteSuccessCallback: () {
          //   _members.remove(member);
          // },
        ),
      ),
    );
    if (result) {
      _getMembers();
    }
  }
}
