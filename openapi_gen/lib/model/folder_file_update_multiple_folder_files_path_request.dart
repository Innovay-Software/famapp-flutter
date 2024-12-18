//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class FolderFileUpdateMultipleFolderFilesPathRequest {
  /// Returns a new [FolderFileUpdateMultipleFolderFilesPathRequest] instance.
  FolderFileUpdateMultipleFolderFilesPathRequest({
    this.folderFileIds = const [],
    this.newFolderId,
    this.newShotAtTimestamp,
  });

  List<int> folderFileIds;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? newFolderId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? newShotAtTimestamp;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FolderFileUpdateMultipleFolderFilesPathRequest &&
    _deepEquality.equals(other.folderFileIds, folderFileIds) &&
    other.newFolderId == newFolderId &&
    other.newShotAtTimestamp == newShotAtTimestamp;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (folderFileIds.hashCode) +
    (newFolderId == null ? 0 : newFolderId!.hashCode) +
    (newShotAtTimestamp == null ? 0 : newShotAtTimestamp!.hashCode);

  @override
  String toString() => 'FolderFileUpdateMultipleFolderFilesPathRequest[folderFileIds=$folderFileIds, newFolderId=$newFolderId, newShotAtTimestamp=$newShotAtTimestamp]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'folderFileIds'] = this.folderFileIds;
    if (this.newFolderId != null) {
      json[r'newFolderId'] = this.newFolderId;
    } else {
      json[r'newFolderId'] = null;
    }
    if (this.newShotAtTimestamp != null) {
      json[r'newShotAtTimestamp'] = this.newShotAtTimestamp;
    } else {
      json[r'newShotAtTimestamp'] = null;
    }
    return json;
  }

  /// Returns a new [FolderFileUpdateMultipleFolderFilesPathRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FolderFileUpdateMultipleFolderFilesPathRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FolderFileUpdateMultipleFolderFilesPathRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FolderFileUpdateMultipleFolderFilesPathRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FolderFileUpdateMultipleFolderFilesPathRequest(
        folderFileIds: json[r'folderFileIds'] is Iterable
            ? (json[r'folderFileIds'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        newFolderId: mapValueOfType<int>(json, r'newFolderId'),
        newShotAtTimestamp: mapValueOfType<int>(json, r'newShotAtTimestamp'),
      );
    }
    return null;
  }

  static List<FolderFileUpdateMultipleFolderFilesPathRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FolderFileUpdateMultipleFolderFilesPathRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FolderFileUpdateMultipleFolderFilesPathRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FolderFileUpdateMultipleFolderFilesPathRequest> mapFromJson(dynamic json) {
    final map = <String, FolderFileUpdateMultipleFolderFilesPathRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FolderFileUpdateMultipleFolderFilesPathRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FolderFileUpdateMultipleFolderFilesPathRequest-objects as value to a dart map
  static Map<String, List<FolderFileUpdateMultipleFolderFilesPathRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FolderFileUpdateMultipleFolderFilesPathRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FolderFileUpdateMultipleFolderFilesPathRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'folderFileIds',
  };
}

