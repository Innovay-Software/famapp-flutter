import 'package:either_dart/either.dart';
import 'package:famapp/core/utils/datetime_util.dart';

import '../../../../core/config.dart';
import '../../../../core/errors/data_fetch_error.dart';
import '../../../../core/utils/debug_utils.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../../core/utils/use_case_exception_handler.dart';
import '../../model/album.dart';
import '../../model/album_file.dart';

class LoadAlbumFiles {
  Future<Either<DataFetchError, bool>> call({
    required Album album,
    required bool forceReload,
    required DateTime pivotDate,
    required DateTime beforeShotAtDateTime,
  }) async {
    try {
      final url = InnoConfig.mainNetworkConfig.getFolderFilesBeforeMicroTimestamp(
        album.id,
        DatetimeUtils.formattedDate(pivotDate),
        beforeShotAtDateTime.toUtc().microsecondsSinceEpoch,
      );
      final Map<String, dynamic> dataLoad = {};
      final response = await NetworkManager.postRequestSync(url, dataLoad: dataLoad);

      if (forceReload) {
        album.files.clear();
      }
      DebugManager.log("HasMore = ${response['data']['hasMore']}");
      for (var item in response['data']['folderFiles']) {
        var newFile = AlbumFile.fromJson(item);
        album.files.add(newFile);
      }

      final albumJsonData = response['data']['folder'];
      album.syncFromRawData(albumJsonData);

      album.totalFiles = int.tryParse('${response['data']['folder']['totalFiles']}') ?? 0;
      album.hasMore = bool.tryParse('${response['data']['hasMore']}') ?? true;
      album.saveLocalCache();

      return const Right(true);
    } catch (e, stacktrace) {
      return Left(UseCaseExceptionHandler.defaultHandler(e, stacktrace));
    }
  }
}
