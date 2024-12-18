//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UploadedDocument {
  /// Returns a new [UploadedDocument] instance.
  UploadedDocument({
    this.id,
    this.userId,
    this.disk,
    this.fileName,
    this.fileType,
    this.filePath,
    this.fileUrl,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? userId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? disk;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? fileName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? fileType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? filePath;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? fileUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UploadedDocument &&
    other.id == id &&
    other.userId == userId &&
    other.disk == disk &&
    other.fileName == fileName &&
    other.fileType == fileType &&
    other.filePath == filePath &&
    other.fileUrl == fileUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (userId == null ? 0 : userId!.hashCode) +
    (disk == null ? 0 : disk!.hashCode) +
    (fileName == null ? 0 : fileName!.hashCode) +
    (fileType == null ? 0 : fileType!.hashCode) +
    (filePath == null ? 0 : filePath!.hashCode) +
    (fileUrl == null ? 0 : fileUrl!.hashCode);

  @override
  String toString() => 'UploadedDocument[id=$id, userId=$userId, disk=$disk, fileName=$fileName, fileType=$fileType, filePath=$filePath, fileUrl=$fileUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.userId != null) {
      json[r'userId'] = this.userId;
    } else {
      json[r'userId'] = null;
    }
    if (this.disk != null) {
      json[r'disk'] = this.disk;
    } else {
      json[r'disk'] = null;
    }
    if (this.fileName != null) {
      json[r'fileName'] = this.fileName;
    } else {
      json[r'fileName'] = null;
    }
    if (this.fileType != null) {
      json[r'fileType'] = this.fileType;
    } else {
      json[r'fileType'] = null;
    }
    if (this.filePath != null) {
      json[r'filePath'] = this.filePath;
    } else {
      json[r'filePath'] = null;
    }
    if (this.fileUrl != null) {
      json[r'fileUrl'] = this.fileUrl;
    } else {
      json[r'fileUrl'] = null;
    }
    return json;
  }

  /// Returns a new [UploadedDocument] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UploadedDocument? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UploadedDocument[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UploadedDocument[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UploadedDocument(
        id: mapValueOfType<int>(json, r'id'),
        userId: mapValueOfType<int>(json, r'userId'),
        disk: mapValueOfType<String>(json, r'disk'),
        fileName: mapValueOfType<String>(json, r'fileName'),
        fileType: mapValueOfType<String>(json, r'fileType'),
        filePath: mapValueOfType<String>(json, r'filePath'),
        fileUrl: mapValueOfType<String>(json, r'fileUrl'),
      );
    }
    return null;
  }

  static List<UploadedDocument> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UploadedDocument>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UploadedDocument.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UploadedDocument> mapFromJson(dynamic json) {
    final map = <String, UploadedDocument>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UploadedDocument.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UploadedDocument-objects as value to a dart map
  static Map<String, List<UploadedDocument>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UploadedDocument>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UploadedDocument.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

