//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LockerNote {
  /// Returns a new [LockerNote] instance.
  LockerNote({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.content,
    this.inviteeIds = const [],
  });

  int id;

  /// owner's userId
  int ownerId;

  /// title of the note
  String title;

  /// text content of the note
  String content;

  /// the userIds of all invitees
  List<int> inviteeIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LockerNote &&
    other.id == id &&
    other.ownerId == ownerId &&
    other.title == title &&
    other.content == content &&
    _deepEquality.equals(other.inviteeIds, inviteeIds);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (ownerId.hashCode) +
    (title.hashCode) +
    (content.hashCode) +
    (inviteeIds.hashCode);

  @override
  String toString() => 'LockerNote[id=$id, ownerId=$ownerId, title=$title, content=$content, inviteeIds=$inviteeIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'ownerId'] = this.ownerId;
      json[r'title'] = this.title;
      json[r'content'] = this.content;
      json[r'inviteeIds'] = this.inviteeIds;
    return json;
  }

  /// Returns a new [LockerNote] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LockerNote? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LockerNote[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LockerNote[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LockerNote(
        id: mapValueOfType<int>(json, r'id')!,
        ownerId: mapValueOfType<int>(json, r'ownerId')!,
        title: mapValueOfType<String>(json, r'title')!,
        content: mapValueOfType<String>(json, r'content')!,
        inviteeIds: json[r'inviteeIds'] is Iterable
            ? (json[r'inviteeIds'] as Iterable).cast<int>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<LockerNote> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LockerNote>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LockerNote.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LockerNote> mapFromJson(dynamic json) {
    final map = <String, LockerNote>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LockerNote.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LockerNote-objects as value to a dart map
  static Map<String, List<LockerNote>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LockerNote>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LockerNote.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'ownerId',
    'title',
    'content',
    'inviteeIds',
  };
}

