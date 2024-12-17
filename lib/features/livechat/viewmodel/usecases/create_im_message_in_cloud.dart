// import 'package:either_dart/either.dart';
//
// import '../../../../core/config.dart';
// import '../../../../core/errors/data_fetch_error.dart';
// import '../../../../core/global_data.dart';
// import '../../../../core/utils/network_utils.dart';
// import '../../../../core/utils/use_case_exception_handler.dart';
// import '../../model/livechat_message.dart';
//
// class CreateImMessageInCloud {
//   Future<Either<DataFetchError, dynamic>> call({required ImMessage imMessage}) async {
//     try {
//       final response = await NetworkManager.postRequestSync(
//         InnoConfig.imNetworkConfig.sendMessage(imMessage.imGroupId),
//         dataLoad: {
//           'type': imMessage.type.toShortString(),
//           'body': imMessage.body,
//           'deviceToken': InnoGlobalData.deviceToken,
//         },
//       );
//
//       return Right(response);
//     } catch (e, stacktrace) {
//       return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
//     }
//   }
// }
