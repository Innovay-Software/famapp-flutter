// import 'package:either_dart/either.dart';
//
// import '../errors/data_fetch_error.dart';
// import '../utils/use_case_exception_handler.dart';
//
// abstract class InnoUseCase {
//   Future<Either<DataFetchError, bool>> handleUseCaseAction(Function() useCaseAction) async {
//     try {
//       await useCaseAction();
//       return const Right(true);
//     } catch (e, stacktrace) {
//       return Left(UseCaseExceptionHandler.defaultHandler2(e, stacktrace));
//     }
//   }
// }
