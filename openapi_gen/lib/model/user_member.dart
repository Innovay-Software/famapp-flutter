//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserMember {
  /// Returns a new [UserMember] instance.
  UserMember({
    required this.id,
    required this.name,
    required this.role,
    required this.mobile,
    required this.avatar,
  });

  int id;

  String name;

  UserRoleEnum role;

  String mobile;

  String avatar;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserMember &&
    other.id == id &&
    other.name == name &&
    other.role == role &&
    other.mobile == mobile &&
    other.avatar == avatar;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (role.hashCode) +
    (mobile.hashCode) +
    (avatar.hashCode);

  @override
  String toString() => 'UserMember[id=$id, name=$name, role=$role, mobile=$mobile, avatar=$avatar]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
      json[r'role'] = this.role;
      json[r'mobile'] = this.mobile;
      json[r'avatar'] = this.avatar;
    return json;
  }

  /// Returns a new [UserMember] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserMember? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserMember[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserMember[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserMember(
        id: mapValueOfType<int>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        role: UserRoleEnum.fromJson(json[r'role'])!,
        mobile: mapValueOfType<String>(json, r'mobile')!,
        avatar: mapValueOfType<String>(json, r'avatar')!,
      );
    }
    return null;
  }

  static List<UserMember> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserMember>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserMember.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserMember> mapFromJson(dynamic json) {
    final map = <String, UserMember>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserMember.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserMember-objects as value to a dart map
  static Map<String, List<UserMember>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserMember>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserMember.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'role',
    'mobile',
    'avatar',
  };
}

