import 'package:famapp/features/livechat/pb/message_user.pb.dart' as PBUser;

class LivechatUserInGroupModel {
  final String name;
  final String uuid;
  final String avatar;

  LivechatUserInGroupModel(this.name, this.uuid, this.avatar);

  factory LivechatUserInGroupModel.fromPBUserInGroupModel(PBUser.UserInGroup pbUserInGroup) {
    return LivechatUserInGroupModel(pbUserInGroup.name, pbUserInGroup.uuid, pbUserInGroup.avatar);
  }

  factory LivechatUserInGroupModel.fromLivechatUserModel(LivechatUserModel userModel) {
    return LivechatUserInGroupModel(userModel.name, userModel.uuid, userModel.avatar);
  }
}

class LivechatUserModel {
  final String id;
  final String uuid;
  final int familyID;
  final String name;
  final String email;
  final String mobile;
  final String avatar;

  LivechatUserModel(this.id, this.uuid, this.familyID, this.name, this.email, this.mobile, this.avatar);

  factory LivechatUserModel.fromPBUserModel(PBUser.User pbUser) {
    return LivechatUserModel(
      pbUser.id,
      pbUser.uuid,
      pbUser.familyId,
      pbUser.name,
      pbUser.email,
      pbUser.mobile,
      pbUser.avatar,
    );
  }

  factory LivechatUserModel.dummy() {
    return LivechatUserModel("", "", 0, "", "", "", "");
  }

  bool isDummy() {
    return id == "";
  }

  // factory ImUserModel.fromJson(dynamic jsonData) {
  //   return ImUserModel(
  //     int.tryParse('${jsonData['id']}') ?? 0,
  //     '${jsonData['name']}',
  //     '${jsonData['email']}',
  //     '${jsonData['mobile']}',
  //   );
  // }
}

// class
