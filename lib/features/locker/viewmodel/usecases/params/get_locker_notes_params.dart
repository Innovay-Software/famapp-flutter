import '../../../../../core/abstracts/inno_params.dart';

class GetLockerNotesParams extends InnoParams {
  final int page;
  final int pageSize;

  GetLockerNotesParams({required this.page, required this.pageSize});

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}
