//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminSaveUserPathRequest {
  /// Returns a new [AdminSaveUserPathRequest] instance.
  AdminSaveUserPathRequest({
    required this.name,
    required this.mobile,
    this.password,
    this.lockerPasscode,
    required this.role,
    this.familyId,
  });

  String name;

  String mobile;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? password;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lockerPasscode;

  String role;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? familyId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminSaveUserPathRequest &&
    other.name == name &&
    other.mobile == mobile &&
    other.password == password &&
    other.lockerPasscode == lockerPasscode &&
    other.role == role &&
    other.familyId == familyId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (mobile.hashCode) +
    (password == null ? 0 : password!.hashCode) +
    (lockerPasscode == null ? 0 : lockerPasscode!.hashCode) +
    (role.hashCode) +
    (familyId == null ? 0 : familyId!.hashCode);

  @override
  String toString() => 'AdminSaveUserPathRequest[name=$name, mobile=$mobile, password=$password, lockerPasscode=$lockerPasscode, role=$role, familyId=$familyId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'mobile'] = this.mobile;
    if (this.password != null) {
      json[r'password'] = this.password;
    } else {
      json[r'password'] = null;
    }
    if (this.lockerPasscode != null) {
      json[r'lockerPasscode'] = this.lockerPasscode;
    } else {
      json[r'lockerPasscode'] = null;
    }
      json[r'role'] = this.role;
    if (this.familyId != null) {
      json[r'familyId'] = this.familyId;
    } else {
      json[r'familyId'] = null;
    }
    return json;
  }

  /// Returns a new [AdminSaveUserPathRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminSaveUserPathRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminSaveUserPathRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminSaveUserPathRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminSaveUserPathRequest(
        name: mapValueOfType<String>(json, r'name')!,
        mobile: mapValueOfType<String>(json, r'mobile')!,
        password: mapValueOfType<String>(json, r'password'),
        lockerPasscode: mapValueOfType<String>(json, r'lockerPasscode'),
        role: mapValueOfType<String>(json, r'role')!,
        familyId: mapValueOfType<int>(json, r'familyId'),
      );
    }
    return null;
  }

  static List<AdminSaveUserPathRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminSaveUserPathRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminSaveUserPathRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminSaveUserPathRequest> mapFromJson(dynamic json) {
    final map = <String, AdminSaveUserPathRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminSaveUserPathRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminSaveUserPathRequest-objects as value to a dart map
  static Map<String, List<AdminSaveUserPathRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminSaveUserPathRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminSaveUserPathRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'mobile',
    'role',
  };
}

