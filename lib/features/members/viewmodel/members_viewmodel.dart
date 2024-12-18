import 'package:famapp/features/members/viewmodel/usecases/list_members.dart';

import '../../../core/abstracts/inno_viewmodel.dart';
import '../model/member_model.dart';
import 'usecases/delete_member.dart';
import 'usecases/save_member.dart';

class MemberViewmodel extends InnoViewmodel {
  static final MemberViewmodel _instance = MemberViewmodel._internal();
  factory MemberViewmodel() => _instance;
  MemberViewmodel._internal();

  final List<Member> _members = [];
  List<Member> get members => _members;

  Future<bool> listMembers() async {
    final useCase = ListMembers();
    final response = await useCase.call(members: _members, afterId: 0);
    if (!validateUseCaseResponse2(response)) {
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> saveMember({required Member member}) async {
    final useCase = SaveMember();
    final response = await useCase.call(
      members: _members,
      newMember: member,
    );
    if (!validateUseCaseResponse2(response)) {
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> deleteMember({required Member member}) async {
    final useCase = DeleteMember();
    final response = await useCase.call(members: _members, userUuid: member.uuid);
    if (!validateUseCaseResponse2(response)) {
      return false;
    }
    for (var i = 0; i < _members.length; i++) {
      if (_members[i].id == member.id) {
        _members.removeAt(i);
        break;
      }
    }
    notifyListeners();
    return true;
  }

  Member? searchForMember(int id) {
    for (var item in _members) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }
}
