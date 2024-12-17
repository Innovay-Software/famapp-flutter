import '../errors/data_fetch_error.dart';
import '../exceptions/inno_api_exception.dart';
import 'debug_utils.dart';

class UseCaseExceptionHandler {
  static DataFetchError defaultHandler(Object e, StackTrace stacktrace) {
    var error = 'Network Error';
    if (e is InnoApiException) {
      error = e.errorMessage();
      DebugManager.log("UseCaseException.DefaultHandler");
      DebugManager.log((e).fullErrorMessage());
      DebugManager.log(stacktrace.toString());
    }
    return DataFetchError(errorMessage: error);
  }
}
