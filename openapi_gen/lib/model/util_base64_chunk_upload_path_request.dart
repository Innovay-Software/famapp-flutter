//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UtilBase64ChunkUploadPathRequest {
  /// Returns a new [UtilBase64ChunkUploadPathRequest] instance.
  UtilBase64ChunkUploadPathRequest({
    required this.base64EncodedContent,
    required this.fileName,
    required this.chunkedFileName,
    required this.hasMore,
  });

  String base64EncodedContent;

  String fileName;

  String chunkedFileName;

  bool hasMore;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UtilBase64ChunkUploadPathRequest &&
    other.base64EncodedContent == base64EncodedContent &&
    other.fileName == fileName &&
    other.chunkedFileName == chunkedFileName &&
    other.hasMore == hasMore;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (base64EncodedContent.hashCode) +
    (fileName.hashCode) +
    (chunkedFileName.hashCode) +
    (hasMore.hashCode);

  @override
  String toString() => 'UtilBase64ChunkUploadPathRequest[base64EncodedContent=$base64EncodedContent, fileName=$fileName, chunkedFileName=$chunkedFileName, hasMore=$hasMore]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'base64EncodedContent'] = this.base64EncodedContent;
      json[r'fileName'] = this.fileName;
      json[r'chunkedFileName'] = this.chunkedFileName;
      json[r'hasMore'] = this.hasMore;
    return json;
  }

  /// Returns a new [UtilBase64ChunkUploadPathRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UtilBase64ChunkUploadPathRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UtilBase64ChunkUploadPathRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UtilBase64ChunkUploadPathRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UtilBase64ChunkUploadPathRequest(
        base64EncodedContent: mapValueOfType<String>(json, r'base64EncodedContent')!,
        fileName: mapValueOfType<String>(json, r'fileName')!,
        chunkedFileName: mapValueOfType<String>(json, r'chunkedFileName')!,
        hasMore: mapValueOfType<bool>(json, r'hasMore')!,
      );
    }
    return null;
  }

  static List<UtilBase64ChunkUploadPathRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UtilBase64ChunkUploadPathRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UtilBase64ChunkUploadPathRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UtilBase64ChunkUploadPathRequest> mapFromJson(dynamic json) {
    final map = <String, UtilBase64ChunkUploadPathRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UtilBase64ChunkUploadPathRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UtilBase64ChunkUploadPathRequest-objects as value to a dart map
  static Map<String, List<UtilBase64ChunkUploadPathRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UtilBase64ChunkUploadPathRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UtilBase64ChunkUploadPathRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'base64EncodedContent',
    'fileName',
    'chunkedFileName',
    'hasMore',
  };
}

