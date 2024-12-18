//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/admin_api.dart';
part 'api/auth_api.dart';
part 'api/folder_file_api.dart';
part 'api/folder_file_upload_api.dart';
part 'api/locker_notes_api.dart';
part 'api/user_api.dart';
part 'api/util_api.dart';

part 'model/admin_add_user_path_request.dart';
part 'model/admin_save_user_path_request.dart';
part 'model/auth_access_token_login_path_request.dart';
part 'model/auth_mobile_login_path_request.dart';
part 'model/folder_file_delete_folder_files_path_request.dart';
part 'model/folder_file_save_folder_path_request.dart';
part 'model/folder_file_update_multiple_folder_files_path_request.dart';
part 'model/folder_file_update_single_folder_file_path_request.dart';
part 'model/locker_note.dart';
part 'model/locker_note_save_path_request.dart';
part 'model/uploaded_document.dart';
part 'model/user.dart';
part 'model/user_member.dart';
part 'model/user_role_enum.dart';
part 'model/user_update_profile_path_request.dart';
part 'model/util_base64_chunk_upload_path_request.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
