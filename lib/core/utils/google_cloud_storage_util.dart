import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

import '../global_data.dart';

class GoogleCloudStorageUtil {
  static String get googleCloudStorageDomain {
    return InnoGlobalData.googleCloudStorageDomain;
  }

  static String get googleCloudStorageAccessId {
    return InnoGlobalData.googleCloudStorageAccessId;
  }

  static String get googleCloudStorageAccessSecretKey {
    return InnoGlobalData.googleCloudStorageAccessSecretKey;
  }

  static String buildGoogleCloudStorageSignedUrl(int validSeconds, String googleCloudStoragePath) {
    ///
    /// Usage:
    /// var storageObjectPath = '/ijayden/album3/1/2024/01/07/2024_01_07_1240.original.jpg';
    /// var signedUrl = OssUtil.buildGoogleCloudStorageSignedUrl(48 * 3600, storageObjectPath);
    ///

    var now = DateTime.now().toUtc();
    var signingAlgorithm = 'GOOG4-HMAC-SHA256';
    var activeDateTime = '${DateFormat('yMMdd-HHmmss').format(now).replaceAll('-', 'T')}Z';
    var credentialScopeDateStamp = DateFormat('yMMdd').format(now);
    var credentialScopeLocation = 'auto';
    var credentialScopeService = 'storage';
    var credentialScope = '$credentialScopeDateStamp/$credentialScopeLocation/$credentialScopeService/goog4_request';
    var canonicalRequest = _buildGoogleCloudStorageCanonicalRequest(
      now,
      validSeconds,
      credentialScope,
      googleCloudStoragePath,
    );
    var canonicalRequestHash = sha256.convert(utf8.encode(canonicalRequest[0]));
    var stringToSign = '$signingAlgorithm\n$activeDateTime\n$credentialScope\n$canonicalRequestHash';

    // Up to here, everything is identical to the python program provided by Google Cloud, StringToSign is identical

    var key1 = 'GOOG4$googleCloudStorageAccessSecretKey';
    var signingKeyStep1 = Hmac(sha256, utf8.encode(key1)).convert(utf8.encode(credentialScopeDateStamp));
    var signingKeyStep2 = Hmac(sha256, signingKeyStep1.bytes).convert(utf8.encode(credentialScopeLocation));
    var signingKeyStep3 = Hmac(sha256, signingKeyStep2.bytes).convert(utf8.encode(credentialScopeService));
    var signingKeyFinal = Hmac(sha256, signingKeyStep3.bytes).convert(utf8.encode('goog4_request'));
    var signature = Hmac(sha256, signingKeyFinal.bytes).convert(utf8.encode(stringToSign)).toString();

    return 'https://$googleCloudStorageDomain$googleCloudStoragePath?${canonicalRequest[1]}&x-goog-signature=$signature';
  }

  static List<String> _buildGoogleCloudStorageCanonicalRequest(
    DateTime now,
    int validSeconds,
    String credentialScope,
    String gscPath,
  ) {
    var httpVerb = 'GET';
    var pathToResource = gscPath;
    var canonicalQueryString = '';
    var canonicalHeaders = {
      'host': googleCloudStorageDomain,
    };
    var signedHeaders = canonicalHeaders.keys.join(';');
    var payload = 'UNSIGNED-PAYLOAD';

    var queryStrings = {
      'X-Goog-Algorithm': 'GOOG4-HMAC-SHA256',
      'X-Goog-Credential': Uri.encodeComponent('$googleCloudStorageAccessId/$credentialScope'),
      'X-Goog-Date': '${DateFormat('yMMdd-HHmmss').format(now).replaceAll('-', 'T')}Z',
      'X-Goog-Expires': validSeconds,
      'X-Goog-SignedHeaders': canonicalHeaders.keys.join(';'),
    };
    canonicalQueryString = queryStrings.entries.map((e) => '${e.key}=${e.value}').toList().join('&');
    var canonicalHeadersString = canonicalHeaders.entries.map((e) => '${e.key}:${e.value}').toList().join('\n');
    var result =
        "$httpVerb\n$pathToResource\n$canonicalQueryString\n$canonicalHeadersString\n\n$signedHeaders\n$payload";
    return [result, canonicalQueryString];
  }
}
