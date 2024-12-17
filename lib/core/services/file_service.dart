import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';

import '../global_data.dart';

class FileService {
  static Future<List<String>> pickMedias(int count, bool useFastMode, bool imageOnly, bool videoOnly) async {
    var pickedMediaPaths = <String>[];
    if (count < 1) {
      return pickedMediaPaths;
    }

    // Fast mode: smaller size, faster response time, but not original file, and files are missing EXIF data
    // Slow mode: original file, but can be very slow in responsiveness
    //            because ios needs to download the original  file from icloud

    if (useFastMode) {
      final pickType = imageOnly
          ? PickType.image
          : videoOnly
              ? PickType.video
              : PickType.all;
      final List<Media>? pickedMedias = await ImagesPicker.pick(count: count, pickType: pickType);
      if (pickedMedias != null && pickedMedias.isNotEmpty) {
        for (var item in pickedMedias) {
          pickedMediaPaths.add(item.path);
        }
      }
    } else {
      final picker = ImagePicker();
      InnoGlobalData.switchLoadingOverlay(true);
      final List<XFile> pickedMedias = <XFile>[];
      if (count == 1) {
        final picked = imageOnly
            ? await picker.pickImage(source: ImageSource.gallery)
            : videoOnly
                ? await picker.pickVideo(source: ImageSource.gallery)
                : await picker.pickMedia();
        if (picked != null) {
          pickedMedias.add(picked);
        }
      } else {
        pickedMedias.addAll(
            imageOnly ? await picker.pickMultiImage(limit: count) : await picker.pickMultipleMedia(limit: count));
      }
      InnoGlobalData.switchLoadingOverlay(false);
      for (var item in pickedMedias) {
        pickedMediaPaths.add(item.path);
      }
    }
    return pickedMediaPaths;
  }
}
