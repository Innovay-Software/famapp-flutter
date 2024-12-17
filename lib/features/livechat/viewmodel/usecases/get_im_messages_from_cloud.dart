// import 'package:either_dart/either.dart';
//
// import '../../../../core/config.dart';
// import '../../../../core/errors/data_fetch_error.dart';
// import '../../../../core/utils/network_utils.dart';
// import '../../../../core/utils/use_case_exception_handler.dart';
//
// class GetImMessagesFromCloud {
//   Future<Either<DataFetchError, dynamic>> call({required int imGroupId, required int afterId}) async {
//     try {
//       final url = InnoConfig.imNetworkConfig.getImMessages(imGroupId, afterId);
//       final response = await NetworkManager.postRequestSync(url);
//       return Right(response);
//     } catch (e, stacktrace) {
//       return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
//     }
//   }
// }
