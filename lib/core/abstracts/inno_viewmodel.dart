import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

import '../errors/data_fetch_error.dart';
import '../utils/snack_bar_manager.dart';

abstract class InnoViewmodel extends ChangeNotifier {
  bool validateUseCaseResponse(Either<DataFetchError, dynamic> response) {
    if (response.isLeft || response is DataFetchError) {
      SnackBarManager.displayMessage(response.left.errorMessage);
      return false;
    }
    return true;
  }
}
