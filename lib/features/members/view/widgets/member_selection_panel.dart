import 'package:flutter/cupertino.dart';

import '../../../../core/widgets/innovay_text.dart';
import '../../../settings/viewmodel/user_viewmodel.dart';
import '../../model/member_model.dart';
import '../../viewmodel/members_viewmodel.dart';
import 'member_selection_member_bar.dart';

class MemberSelectionPanel extends StatefulWidget {
  final String title;
  final Function(List<int>) onSelectionUpdated;
  final List<int> selectedIds;
  const MemberSelectionPanel({
    super.key,
    required this.title,
    required this.onSelectionUpdated,
    this.selectedIds = const [],
  });

  @override
  State<MemberSelectionPanel> createState() => _MemberSelectionPanelState();
}

class _MemberSelectionPanelState extends State<MemberSelectionPanel> {
  final MemberViewmodel _memberViewmodel = MemberViewmodel();
  final List<Member> _potentialMembers = [];
  final List<int> _selectedIds = [];

  @override
  void initState() {
    super.initState();
    _selectedIds.addAll(widget.selectedIds);
    _potentialMembers.clear();
    _potentialMembers.addAll(_memberViewmodel.members);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserViewmodel().currentUser;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: InnoText(widget.title, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...(_potentialMembers.map((invitee) {
            if (invitee.id == user.id) {
              return const SizedBox.shrink();
            }
            return MemberSelectionMemberBar(
              member: invitee,
              selected: _selectedIds.contains(invitee.id),
              onTap: () {
                if (_selectedIds.contains(invitee.id)) {
                  _selectedIds.remove(invitee.id);
                } else {
                  _selectedIds.add(invitee.id);
                }
                setState(() {});
                widget.onSelectionUpdated(_selectedIds);
              },
            );
          })),
        ],
      ),
    );
  }
}
