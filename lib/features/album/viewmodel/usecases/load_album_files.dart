import 'package:famapp/features/album/viewmodel/datasources/AlbumFilesRemoteDatasource.dart';

import '../../../../core/utils/api_utils.dart';
import '../../model/album.dart';
import '../../model/album_file.dart';

class LoadAlbumFiles {
  Future<ApiResponse> call({
    required Album album,
    required bool forceReload,
    required DateTime pivotDate,
    required DateTime beforeShotAtDateTime,
  }) async {
    final datasource = AlbumFilesRemoteDatasource();
    final microTimestamp = beforeShotAtDateTime.microsecondsSinceEpoch;
    final response = await datasource.getFilesBeforeTimestamp(
      folderId: album.id,
      pivotDate: pivotDate,
      microTimestamp: microTimestamp,
    );

    if (!response.successful) {
      return response;
    }

    // Get total files in album
    final totalFiles = int.tryParse('${response.data['folder']['totalFiles']}') ?? 0;

    // Are there more
    final hasMore = bool.tryParse('${response.data['hasMore']}') ?? true;

    if (forceReload) {
      album.files.clear();
      album.totalFiles = 0;
    }

    for (var item in response.data['folderFiles']) {
      var newFile = AlbumFile.fromJson(item);
      album.files.add(newFile);
    }

    final albumJsonData = response.data['folder'];
    album.syncFromRawData(albumJsonData);

    album.totalFiles = totalFiles;
    album.hasMore = hasMore;
    album.saveLocalCache();
    return response;
  }
}
