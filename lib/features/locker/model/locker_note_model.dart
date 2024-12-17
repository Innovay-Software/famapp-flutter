class LockerNote {
  int id;
  Map<String, dynamic> owner;
  String title;
  String content;
  List<dynamic> invitees;
  DateTime createdAt;
  DateTime updatedAt;

  List<int> get inviteeIds {
    var ids = <int>[];
    for (var item in invitees) {
      ids.add(int.tryParse('${item['id']}') ?? 0);
    }
    return ids;
  }

  LockerNote({
    required this.id,
    required this.owner,
    required this.title,
    required this.content,
    required this.invitees,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LockerNote.fromJson(Map<String, dynamic> json) {
    return LockerNote(
      id: int.tryParse('${json['id']}') ?? 0,
      owner: json['owner'] ?? {},
      title: '${json['title'] ?? ''}',
      content: '${json['content'] ?? ''}',
      invitees: json['invitees'] ?? [],
      createdAt: DateTime.tryParse('${json['createdAt']}') ?? DateTime.now(),
      updatedAt: DateTime.tryParse('${json['updatedAt']}') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerId': owner['id'] ?? 0,
      'title': title,
      'content': content,
      'inviteeIds': inviteeIds,
    };
  }
}
