//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AuthMobileLoginPathRequest {
  /// Returns a new [AuthMobileLoginPathRequest] instance.
  AuthMobileLoginPathRequest({
    required this.mobile,
    required this.password,
    required this.deviceToken,
  });

  String mobile;

  String password;

  String deviceToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AuthMobileLoginPathRequest &&
    other.mobile == mobile &&
    other.password == password &&
    other.deviceToken == deviceToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (mobile.hashCode) +
    (password.hashCode) +
    (deviceToken.hashCode);

  @override
  String toString() => 'AuthMobileLoginPathRequest[mobile=$mobile, password=$password, deviceToken=$deviceToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'mobile'] = this.mobile;
      json[r'password'] = this.password;
      json[r'deviceToken'] = this.deviceToken;
    return json;
  }

  /// Returns a new [AuthMobileLoginPathRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AuthMobileLoginPathRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AuthMobileLoginPathRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AuthMobileLoginPathRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AuthMobileLoginPathRequest(
        mobile: mapValueOfType<String>(json, r'mobile')!,
        password: mapValueOfType<String>(json, r'password')!,
        deviceToken: mapValueOfType<String>(json, r'deviceToken')!,
      );
    }
    return null;
  }

  static List<AuthMobileLoginPathRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AuthMobileLoginPathRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuthMobileLoginPathRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AuthMobileLoginPathRequest> mapFromJson(dynamic json) {
    final map = <String, AuthMobileLoginPathRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AuthMobileLoginPathRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AuthMobileLoginPathRequest-objects as value to a dart map
  static Map<String, List<AuthMobileLoginPathRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AuthMobileLoginPathRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AuthMobileLoginPathRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'mobile',
    'password',
    'deviceToken',
  };
}

