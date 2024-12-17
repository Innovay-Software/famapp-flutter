// import 'package:either_dart/either.dart';
//
// import '../../../../core/config.dart';
// import '../../../../core/errors/data_fetch_error.dart';
// import '../../../../core/utils/debug_utils.dart';
// import '../../../../core/utils/network_utils.dart';
// import '../../../../core/utils/use_case_exception_handler.dart';
//
// class CreateImGroupInCloud {
//   Future<Either<DataFetchError, dynamic>> call({required List<int> chatterUserIds}) async {
//     try {
//       if (chatterUserIds.length != 1) {
//         DebugManager.error("Unsupported");
//         return const Left(DataFetchError(errorMessage: 'Unsupported number of chatterUserIds'));
//       }
//
//       final response = await NetworkManager.postRequestSync(
//         InnoConfig.imNetworkConfig.personalImGroup(chatterUserIds.first),
//       );
//       return Right(response);
//     } catch (e, stacktrace) {
//       return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
//     }
//   }
// }
