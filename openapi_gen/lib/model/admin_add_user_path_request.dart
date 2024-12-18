//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminAddUserPathRequest {
  /// Returns a new [AdminAddUserPathRequest] instance.
  AdminAddUserPathRequest({
    required this.name,
    required this.mobile,
    required this.password,
    required this.lockerPasscode,
    required this.role,
    required this.familyId,
  });

  String name;

  String mobile;

  String password;

  String lockerPasscode;

  String role;

  int familyId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminAddUserPathRequest &&
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
    (password.hashCode) +
    (lockerPasscode.hashCode) +
    (role.hashCode) +
    (familyId.hashCode);

  @override
  String toString() => 'AdminAddUserPathRequest[name=$name, mobile=$mobile, password=$password, lockerPasscode=$lockerPasscode, role=$role, familyId=$familyId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'mobile'] = this.mobile;
      json[r'password'] = this.password;
      json[r'lockerPasscode'] = this.lockerPasscode;
      json[r'role'] = this.role;
      json[r'familyId'] = this.familyId;
    return json;
  }

  /// Returns a new [AdminAddUserPathRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminAddUserPathRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminAddUserPathRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminAddUserPathRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminAddUserPathRequest(
        name: mapValueOfType<String>(json, r'name')!,
        mobile: mapValueOfType<String>(json, r'mobile')!,
        password: mapValueOfType<String>(json, r'password')!,
        lockerPasscode: mapValueOfType<String>(json, r'lockerPasscode')!,
        role: mapValueOfType<String>(json, r'role')!,
        familyId: mapValueOfType<int>(json, r'familyId')!,
      );
    }
    return null;
  }

  static List<AdminAddUserPathRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminAddUserPathRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminAddUserPathRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminAddUserPathRequest> mapFromJson(dynamic json) {
    final map = <String, AdminAddUserPathRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminAddUserPathRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminAddUserPathRequest-objects as value to a dart map
  static Map<String, List<AdminAddUserPathRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminAddUserPathRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminAddUserPathRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'mobile',
    'password',
    'lockerPasscode',
    'role',
    'familyId',
  };
}

