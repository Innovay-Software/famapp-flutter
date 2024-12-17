class UsedAccount {
  int id;
  String name;
  String mobile;
  String avatar;

  UsedAccount({
    required this.id,
    required this.name,
    required this.mobile,
    required this.avatar,
  });

  factory UsedAccount.fromJson(Map<String, dynamic> json) {
    return UsedAccount(
      id: int.tryParse('${json['id']}') ?? 0,
      name: '${json['name'] ?? ''}',
      mobile: '${json['mobile'] ?? ''}',
      avatar: '${json['avatar'] ?? ''}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
    };
  }
}
