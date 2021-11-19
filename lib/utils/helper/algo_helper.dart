import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

class AlgoHelper {
  AlgoHelper._();

  static Future convertToBase64(File file) async {
    final bytes = await Io.File(file.absolute.path).readAsBytes();
    base64Encode(bytes);
    return base64Encode(bytes);
  }

  static String base64Encode(List<int> bytes) => base64.encode(bytes);
}
