import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watermark Camera App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageWithWatermarkScreen(),
    );
  }
}

class ImageWithWatermarkScreen extends StatefulWidget {
  @override
  _ImageWithWatermarkScreenState createState() => _ImageWithWatermarkScreenState();
}

class _ImageWithWatermarkScreenState extends State<ImageWithWatermarkScreen> {
  File? _watermarkedImage;

  Future<File?> captureImageWithWatermark() async {
    final ImagePicker _picker = ImagePicker();

    // Capture image from camera
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) {
      return null; // User canceled the camera
    }

    // Load the captured image
    final imageBytes = await pickedFile.readAsBytes();
    img.Image originalImage = img.decodeImage(imageBytes)!;

    // Create the watermark text
    String watermarkText = 'Watermark';

    // Define the text style and position
    img.drawString(
      originalImage,
      img.arial_24,  // You can change the font here
      20,            // x-position
      originalImage.height - 40,  // y-position (from the bottom)
      watermarkText,
      color: img.getColor(255, 255, 255), // white color for the text
    );

    // Encode the image back to a file
    Uint8List watermarkedImageBytes = Uint8List.fromList(img.encodeJpg(originalImage));

    // Save the watermarked image to a file
    final tempDir = Directory.systemTemp;
    final watermarkedImageFile = await File('${tempDir.path}/watermarked_image.jpg').writeAsBytes(watermarkedImageBytes);

    return watermarkedImageFile;
  }

  Future<void> _captureImage() async {
    File? image = await captureImageWithWatermark();

    if (image != null) {
      setState(() {
        _watermarkedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capture Image with Watermark'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _watermarkedImage == null
                ? Text('No image captured.')
                : Image.file(_watermarkedImage!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _captureImage,
              child: Text('Capture Image with Watermark'),
            ),
          ],
        ),
      ),
    );
  }
}
