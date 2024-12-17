import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../global_data.dart';

class HwObsUtil {
  static String get domain {
    return InnoGlobalData.hwObsDomain;
  }

  static String get bucket {
    return InnoGlobalData.hwObsBucketName;
  }

  static String get accessId {
    return InnoGlobalData.hwObsAccessId;
  }

  static String get accessSecretKey {
    return InnoGlobalData.hwObsAccessSecretKey;
  }

  static String buildSignedUrl(int validSeconds, String obsPath, String fileType) {
    var md5 = '';
    var contentType = '';
    var expireTimeStamp = (DateTime.now().toUtc().millisecondsSinceEpoch / 1000).floor() + validSeconds;
    var stringToSign = "GET\n$md5\n$contentType\n$expireTimeStamp\n/$bucket/$obsPath";

    var signature = Hmac(sha1, utf8.encode(accessSecretKey)).convert(utf8.encode(stringToSign));
    var signatureBase64 = base64Encode(signature.bytes);
    var signatureBase64UrlEncode = Uri.encodeComponent(signatureBase64);

    return "https://$bucket.$domain/$obsPath?AccessKeyId=$accessId&Expires=$expireTimeStamp&Signature=$signatureBase64UrlEncode";
  }
}
