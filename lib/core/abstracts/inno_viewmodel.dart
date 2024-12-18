import 'package:flutter/material.dart';

import '../utils/api_utils.dart';

abstract class InnoViewmodel extends ChangeNotifier {
  bool validateUseCaseResponse2(ApiResponse response) {
    return response.successful;
  }
}
