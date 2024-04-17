import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ControllerData {
  Future<Uint8List?> getImageGalery({required bool camera}) async {
    try {
      final ImagePicker picker = await ImagePicker();
      Uint8List? image;
      final dataImage = await picker.pickImage(
        imageQuality: 30,
        source: camera == true ? ImageSource.camera : ImageSource.gallery,
      );
      if (dataImage != null) {
        image = await dataImage.readAsBytes();
      }

      return image;
    } catch (e) {
      throw Exception(e);
    }
  }
}
