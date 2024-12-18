import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:images_picker/images_picker.dart';

import '../models/inno_file_upload_item.dart';
import 'debug_utils.dart';
import 'snack_bar_manager.dart';

class FileUtils {
  static void pickImagesFromGallery(int maxImageCount, Function(List<InnoFileUploadItem>) successCallback,
      {int? maxWidth, int? maxHeight}) async {
    DebugManager.log('pickImagesFromGallery');
    // return;
    final pickedImages = await ImagesPicker.pick(
      count: 20,
      pickType: PickType.image,
      maxSize: (maxWidth != null && maxHeight != null) ? max(maxWidth, maxHeight) : null,
    );
    // final picker = ImagePicker();
    // final List<XFile> pickedImageList = await picker.pickMultiImage(maxWidth: maxWidth, maxHeight: maxHeight);

    if (pickedImages != null) {
      List<InnoFileUploadItem> pickedFileUploadItems = [];
      for (var i = 0; i < pickedImages.length && i < maxImageCount; i++) {
        // File imageFile = File(pickedImageList[i].path);
        // Uint8List imageBytes = await imageFile.readAsBytes();
        // String base64String = base64.encode(imageBytes);
        // DebugManager.Log('base64 length: ${base64String.length}');
        // var lastModified = await pickedImageList[i].lastModified();
        DebugManager.log("picked file: ${pickedImages[i].path}");
        pickedFileUploadItems.add(InnoFileUploadItem(pickedImages[i].path, '', false, false, DateTime.now()));
        // {'path': pickedImageList[i].path, 'imageFile': imageFile, 'base64': base64String});
      }
      successCallback(pickedFileUploadItems);
    }
  }

  static void pickMediasFromGallery(
    int maxImageCount,
    Function(List<InnoFileUploadItem>) successCallback, {
    int? maxWidth,
    int? maxHeight,
  }) async {
    DebugManager.log('pickMediasFromGallery');

    final pickedMedias = await ImagesPicker.pick(
      count: 20,
      pickType: PickType.all,
      maxSize: (maxWidth != null && maxHeight != null) ? max(maxWidth, maxHeight) : null,
    );

    if (pickedMedias != null) {
      List<InnoFileUploadItem> pickedFileUploadItems = [];
      for (var i = 0; i < pickedMedias.length && i < maxImageCount; i++) {
        // File imageFile = File(pickedImageList[i].path);
        // Uint8List imageBytes = await imageFile.readAsBytes();
        // String base64String = base64.encode(imageBytes);
        // DebugManager.Log('base64 length: ${base64String.length}');

        // var lastModified = await pickedImageList[i].lastModified();
        pickedFileUploadItems.add(InnoFileUploadItem(pickedMedias[i].path, '', false, false, DateTime.now()));
        // {'path': pickedImageList[i].path, 'imageFile': imageFile, 'base64': base64String});
      }
      successCallback(pickedFileUploadItems);
    }
  }

  static void pickFiles(int maxImageCount, Function(List<InnoFileUploadItem>) successCallback) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      var fileUploadItems = <InnoFileUploadItem>[];
      result.paths.map((path) async {
        if (path == null || path.isEmpty) return;
        fileUploadItems.add(InnoFileUploadItem(path, '', false, false, DateTime.now()));
      });

      successCallback(fileUploadItems);
    } else {
      SnackBarManager.displayMessage('No files selected');
    }
  }
}
