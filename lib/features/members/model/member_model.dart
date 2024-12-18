class Member {
  int id = 0;
  int familyId = 0;
  String uuid = '';
  String name = '';
  String mobile = '';
  String role = '';
  String avatar = '';
  String password = '';
  String lockerPasscode = '';

  Member({
    required this.id,
    required this.familyId,
    required this.uuid,
    required this.name,
    required this.mobile,
    required this.role,
    required this.avatar,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: int.tryParse('${json['id']}') ?? 0,
      familyId: int.tryParse('${json['family_id']}') ?? 0,
      uuid: '${json['uuid'] ?? ''}',
      name: '${json['name'] ?? ''}',
      mobile: '${json['mobile'] ?? ''}',
      avatar: '${json['avatar'] ?? ''}',
      role: '${json['role'] ?? 'member'}',
    );
  }

  Map<String, dynamic> toJson() {
    var map = {
      'name': name,
      'mobile': mobile,
      'role': role,
    };
    if (password.isNotEmpty) {
      map['password'] = password;
    }
    if (lockerPasscode.isNotEmpty) {
      map['lockerPasscode'] = lockerPasscode;
    }

    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  bool isAdmin() {
    return role == 'admin';
  }
}
