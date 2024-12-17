import '../../../core/abstracts/inno_viewmodel.dart';

class UserCenterViewmodel extends InnoViewmodel {
  static final UserCenterViewmodel _instance = UserCenterViewmodel._internal();
  factory UserCenterViewmodel() => _instance;
  UserCenterViewmodel._internal();
}
