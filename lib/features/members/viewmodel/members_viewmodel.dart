import '../../../core/abstracts/inno_viewmodel.dart';
import '../model/member_model.dart';
import 'usecases/delete_member.dart';
import 'usecases/get_members.dart';
import 'usecases/params/delete_member_params.dart';
import 'usecases/params/get_members_params.dart';
import 'usecases/params/save_member_params.dart';
import 'usecases/save_member.dart';

class MemberViewmodel extends InnoViewmodel {
  static final MemberViewmodel _instance = MemberViewmodel._internal();
  factory MemberViewmodel() => _instance;
  MemberViewmodel._internal();

  final List<Member> _members = [];
  List<Member> get members => _members;

  Future<bool> getMembers() async {
    final useCase = GetMembers();
    final response = await useCase.call(params: GetMembersParams());
    if (!validateUseCaseResponse(response)) {
      return false;
    }

    _members.clear();
    _members.addAll(response.right);
    notifyListeners();
    return true;
  }

  Future<bool> saveMember({required Member member}) async {
    final useCase = SaveMember();
    final response = await useCase.call(params: SaveMemberParams(model: member));
    if (!validateUseCaseResponse(response)) {
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> deleteMember({required Member member}) async {
    final useCase = DeleteMember();
    final response = await useCase.call(params: DeleteMemberParams(model: member));
    if (!validateUseCaseResponse(response)) {
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
