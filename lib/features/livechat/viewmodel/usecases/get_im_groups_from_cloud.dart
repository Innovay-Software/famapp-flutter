// import 'package:either_dart/either.dart';
//
// import '../../../../core/config.dart';
// import '../../../../core/errors/data_fetch_error.dart';
// import '../../../../core/utils/debug_utils.dart';
// import '../../../../core/utils/network_utils.dart';
// import '../../../../core/utils/use_case_exception_handler.dart';
//
// class GetImGroupsFromCloud {
//   Future<Either<DataFetchError, dynamic>> call() async {
//     try {
//       DebugManager.log("ImCenterService.syncFromCloud()");
//       final response = await NetworkManager.postRequestSync(InnoConfig.imNetworkConfig.syncImGroups());
//       return Right(response);
//     } catch (e, stacktrace) {
//       return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
//     }
//   }
// }
