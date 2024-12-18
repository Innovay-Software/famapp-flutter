//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserUpdateProfilePathRequest {
  /// Returns a new [UserUpdateProfilePathRequest] instance.
  UserUpdateProfilePathRequest({
    this.name,
    this.mobile,
    this.password,
    this.lockerPasscode,
    this.avatarUrl,
  });

  String? name;

  String? mobile;

  String? password;

  String? lockerPasscode;

  String? avatarUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserUpdateProfilePathRequest &&
    other.name == name &&
    other.mobile == mobile &&
    other.password == password &&
    other.lockerPasscode == lockerPasscode &&
    other.avatarUrl == avatarUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (mobile == null ? 0 : mobile!.hashCode) +
    (password == null ? 0 : password!.hashCode) +
    (lockerPasscode == null ? 0 : lockerPasscode!.hashCode) +
    (avatarUrl == null ? 0 : avatarUrl!.hashCode);

  @override
  String toString() => 'UserUpdateProfilePathRequest[name=$name, mobile=$mobile, password=$password, lockerPasscode=$lockerPasscode, avatarUrl=$avatarUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.mobile != null) {
      json[r'mobile'] = this.mobile;
    } else {
      json[r'mobile'] = null;
    }
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
    if (this.avatarUrl != null) {
      json[r'avatarUrl'] = this.avatarUrl;
    } else {
      json[r'avatarUrl'] = null;
    }
    return json;
  }

  /// Returns a new [UserUpdateProfilePathRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserUpdateProfilePathRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserUpdateProfilePathRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserUpdateProfilePathRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserUpdateProfilePathRequest(
        name: mapValueOfType<String>(json, r'name'),
        mobile: mapValueOfType<String>(json, r'mobile'),
        password: mapValueOfType<String>(json, r'password'),
        lockerPasscode: mapValueOfType<String>(json, r'lockerPasscode'),
        avatarUrl: mapValueOfType<String>(json, r'avatarUrl'),
      );
    }
    return null;
  }

  static List<UserUpdateProfilePathRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserUpdateProfilePathRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserUpdateProfilePathRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserUpdateProfilePathRequest> mapFromJson(dynamic json) {
    final map = <String, UserUpdateProfilePathRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserUpdateProfilePathRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserUpdateProfilePathRequest-objects as value to a dart map
  static Map<String, List<UserUpdateProfilePathRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserUpdateProfilePathRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserUpdateProfilePathRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

