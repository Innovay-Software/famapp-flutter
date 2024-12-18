//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class FolderFileDeleteFolderFilesPathRequest {
  /// Returns a new [FolderFileDeleteFolderFilesPathRequest] instance.
  FolderFileDeleteFolderFilesPathRequest({
    this.folderFileIds = const [],
  });

  List<int> folderFileIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FolderFileDeleteFolderFilesPathRequest &&
    _deepEquality.equals(other.folderFileIds, folderFileIds);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (folderFileIds.hashCode);

  @override
  String toString() => 'FolderFileDeleteFolderFilesPathRequest[folderFileIds=$folderFileIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'folderFileIds'] = this.folderFileIds;
    return json;
  }

  /// Returns a new [FolderFileDeleteFolderFilesPathRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FolderFileDeleteFolderFilesPathRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FolderFileDeleteFolderFilesPathRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FolderFileDeleteFolderFilesPathRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FolderFileDeleteFolderFilesPathRequest(
        folderFileIds: json[r'folderFileIds'] is Iterable
            ? (json[r'folderFileIds'] as Iterable).cast<int>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<FolderFileDeleteFolderFilesPathRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FolderFileDeleteFolderFilesPathRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FolderFileDeleteFolderFilesPathRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FolderFileDeleteFolderFilesPathRequest> mapFromJson(dynamic json) {
    final map = <String, FolderFileDeleteFolderFilesPathRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FolderFileDeleteFolderFilesPathRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FolderFileDeleteFolderFilesPathRequest-objects as value to a dart map
  static Map<String, List<FolderFileDeleteFolderFilesPathRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FolderFileDeleteFolderFilesPathRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FolderFileDeleteFolderFilesPathRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'folderFileIds',
  };
}

