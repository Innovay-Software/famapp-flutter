//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class FolderFileUpdateSingleFolderFilePathRequest {
  /// Returns a new [FolderFileUpdateSingleFolderFilePathRequest] instance.
  FolderFileUpdateSingleFolderFilePathRequest({
    required this.folderFileId,
    this.remark,
    this.isPrivate,
  });

  int folderFileId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? remark;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isPrivate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FolderFileUpdateSingleFolderFilePathRequest &&
    other.folderFileId == folderFileId &&
    other.remark == remark &&
    other.isPrivate == isPrivate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (folderFileId.hashCode) +
    (remark == null ? 0 : remark!.hashCode) +
    (isPrivate == null ? 0 : isPrivate!.hashCode);

  @override
  String toString() => 'FolderFileUpdateSingleFolderFilePathRequest[folderFileId=$folderFileId, remark=$remark, isPrivate=$isPrivate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'folderFileId'] = this.folderFileId;
    if (this.remark != null) {
      json[r'remark'] = this.remark;
    } else {
      json[r'remark'] = null;
    }
    if (this.isPrivate != null) {
      json[r'isPrivate'] = this.isPrivate;
    } else {
      json[r'isPrivate'] = null;
    }
    return json;
  }

  /// Returns a new [FolderFileUpdateSingleFolderFilePathRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FolderFileUpdateSingleFolderFilePathRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FolderFileUpdateSingleFolderFilePathRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FolderFileUpdateSingleFolderFilePathRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FolderFileUpdateSingleFolderFilePathRequest(
        folderFileId: mapValueOfType<int>(json, r'folderFileId')!,
        remark: mapValueOfType<String>(json, r'remark'),
        isPrivate: mapValueOfType<bool>(json, r'isPrivate'),
      );
    }
    return null;
  }

  static List<FolderFileUpdateSingleFolderFilePathRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FolderFileUpdateSingleFolderFilePathRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FolderFileUpdateSingleFolderFilePathRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FolderFileUpdateSingleFolderFilePathRequest> mapFromJson(dynamic json) {
    final map = <String, FolderFileUpdateSingleFolderFilePathRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FolderFileUpdateSingleFolderFilePathRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FolderFileUpdateSingleFolderFilePathRequest-objects as value to a dart map
  static Map<String, List<FolderFileUpdateSingleFolderFilePathRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FolderFileUpdateSingleFolderFilePathRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FolderFileUpdateSingleFolderFilePathRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'folderFileId',
  };
}

