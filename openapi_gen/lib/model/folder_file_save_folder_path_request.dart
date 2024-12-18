//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class FolderFileSaveFolderPathRequest {
  /// Returns a new [FolderFileSaveFolderPathRequest] instance.
  FolderFileSaveFolderPathRequest({
    required this.ownerId,
    required this.parentId,
    required this.title,
    required this.cover,
    required this.type,
    required this.isDefault,
    required this.isPrivate,
    required this.metadata,
    this.inviteeIds = const [],
  });

  int ownerId;

  int parentId;

  String title;

  String cover;

  String type;

  bool isDefault;

  bool isPrivate;

  Object metadata;

  List<int> inviteeIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FolderFileSaveFolderPathRequest &&
    other.ownerId == ownerId &&
    other.parentId == parentId &&
    other.title == title &&
    other.cover == cover &&
    other.type == type &&
    other.isDefault == isDefault &&
    other.isPrivate == isPrivate &&
    other.metadata == metadata &&
    _deepEquality.equals(other.inviteeIds, inviteeIds);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (ownerId.hashCode) +
    (parentId.hashCode) +
    (title.hashCode) +
    (cover.hashCode) +
    (type.hashCode) +
    (isDefault.hashCode) +
    (isPrivate.hashCode) +
    (metadata.hashCode) +
    (inviteeIds.hashCode);

  @override
  String toString() => 'FolderFileSaveFolderPathRequest[ownerId=$ownerId, parentId=$parentId, title=$title, cover=$cover, type=$type, isDefault=$isDefault, isPrivate=$isPrivate, metadata=$metadata, inviteeIds=$inviteeIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'ownerId'] = this.ownerId;
      json[r'parentId'] = this.parentId;
      json[r'title'] = this.title;
      json[r'cover'] = this.cover;
      json[r'type'] = this.type;
      json[r'isDefault'] = this.isDefault;
      json[r'isPrivate'] = this.isPrivate;
      json[r'metadata'] = this.metadata;
      json[r'inviteeIds'] = this.inviteeIds;
    return json;
  }

  /// Returns a new [FolderFileSaveFolderPathRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FolderFileSaveFolderPathRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FolderFileSaveFolderPathRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FolderFileSaveFolderPathRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FolderFileSaveFolderPathRequest(
        ownerId: mapValueOfType<int>(json, r'ownerId')!,
        parentId: mapValueOfType<int>(json, r'parentId')!,
        title: mapValueOfType<String>(json, r'title')!,
        cover: mapValueOfType<String>(json, r'cover')!,
        type: mapValueOfType<String>(json, r'type')!,
        isDefault: mapValueOfType<bool>(json, r'isDefault')!,
        isPrivate: mapValueOfType<bool>(json, r'isPrivate')!,
        metadata: mapValueOfType<Object>(json, r'metadata')!,
        inviteeIds: json[r'inviteeIds'] is Iterable
            ? (json[r'inviteeIds'] as Iterable).cast<int>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<FolderFileSaveFolderPathRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FolderFileSaveFolderPathRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FolderFileSaveFolderPathRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FolderFileSaveFolderPathRequest> mapFromJson(dynamic json) {
    final map = <String, FolderFileSaveFolderPathRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FolderFileSaveFolderPathRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FolderFileSaveFolderPathRequest-objects as value to a dart map
  static Map<String, List<FolderFileSaveFolderPathRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FolderFileSaveFolderPathRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FolderFileSaveFolderPathRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'ownerId',
    'parentId',
    'title',
    'cover',
    'type',
    'isDefault',
    'isPrivate',
    'metadata',
    'inviteeIds',
  };
}

