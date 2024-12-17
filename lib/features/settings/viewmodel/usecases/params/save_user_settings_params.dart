import '../../../../../core/abstracts/inno_params.dart';

class SaveUserSettingsParams extends InnoParams {
  final String name;
  final String mobile;
  final String password;
  final String lockerPasscode;
  final String avatarUrl;

  SaveUserSettingsParams({
    this.name = '',
    this.mobile = '',
    this.password = '',
    this.lockerPasscode = '',
    this.avatarUrl = '',
  });

  @override
  Map<String, dynamic> toMap() {
    var userData = <String, String>{};
    if (name.isNotEmpty) {
      userData['name'] = name;
    }
    if (mobile.isNotEmpty) {
      userData['mobile'] = mobile;
    }
    if (password.isNotEmpty) {
      userData['password'] = password;
    }
    if (lockerPasscode.isNotEmpty) {
      userData['lockerPasscode'] = lockerPasscode;
    }
    if (avatarUrl.isNotEmpty) {
      userData['avatarUrl'] = avatarUrl;
    }
    return userData;
  }
}
