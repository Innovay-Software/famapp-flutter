import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetService {
  Future<bool> connected() async {
    return await InternetConnection().hasInternetAccess;
  }
}
