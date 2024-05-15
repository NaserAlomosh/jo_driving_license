import 'dart:io';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<File?> getImagePicker() async {
  ImagePicker picker = ImagePicker();
  XFile? imagePicked = await picker.pickImage(source: ImageSource.gallery);

  if (imagePicked != null) {
    final File compressedImage = await compressImage(
      imagePicked.path,
    );

    return compressedImage;
  } else {
    return null; // Return null if no image is selected
  }
}

Future<File> compressImage(String imagePath) async {
  final File file = File(imagePath);

  // Read the image
  final List<int> bytes = await file.readAsBytes();
  final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;

  // Resize the image
  final img.Image resizedImage = img.copyResize(image, width: 400);

  // Encode the resized image to a List<int>
  final List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 60);

  // Write the compressed image to a new file
  final File compressedFile = File(imagePath)
    ..writeAsBytesSync(compressedBytes);

  return compressedFile;
}
