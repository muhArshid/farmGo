import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:image_picker/image_picker.dart';

class ImagePickHelper {
  File? selectedFile;
  final picker = ImagePicker();

  Future getSingleImage(ImageSource source) async {
    final pickedFile =
        await picker.getImage(source: source, imageQuality: 60, maxWidth: 400);
    if (pickedFile != null) {
      selectedFile = File(pickedFile.path);
    } else {
      return;
    }
  }

  static Future convertToBase64(File file) async {
    final bytes = await Io.File(file.absolute.path).readAsBytes();
    base64Encode(bytes);
    return base64Encode(bytes);
  }

  convertAndSetImages() {}
}
