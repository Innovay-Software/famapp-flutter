//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LockerNoteSavePathRequest {
  /// Returns a new [LockerNoteSavePathRequest] instance.
  LockerNoteSavePathRequest({
    required this.title,
    required this.content,
    this.inviteeIds = const [],
  });

  String title;

  String content;

  List<int> inviteeIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LockerNoteSavePathRequest &&
    other.title == title &&
    other.content == content &&
    _deepEquality.equals(other.inviteeIds, inviteeIds);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (content.hashCode) +
    (inviteeIds.hashCode);

  @override
  String toString() => 'LockerNoteSavePathRequest[title=$title, content=$content, inviteeIds=$inviteeIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
      json[r'content'] = this.content;
      json[r'inviteeIds'] = this.inviteeIds;
    return json;
  }

  /// Returns a new [LockerNoteSavePathRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LockerNoteSavePathRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LockerNoteSavePathRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LockerNoteSavePathRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LockerNoteSavePathRequest(
        title: mapValueOfType<String>(json, r'title')!,
        content: mapValueOfType<String>(json, r'content')!,
        inviteeIds: json[r'inviteeIds'] is Iterable
            ? (json[r'inviteeIds'] as Iterable).cast<int>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<LockerNoteSavePathRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LockerNoteSavePathRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LockerNoteSavePathRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LockerNoteSavePathRequest> mapFromJson(dynamic json) {
    final map = <String, LockerNoteSavePathRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LockerNoteSavePathRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LockerNoteSavePathRequest-objects as value to a dart map
  static Map<String, List<LockerNoteSavePathRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LockerNoteSavePathRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LockerNoteSavePathRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'content',
  };
}

