import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

File file=File("");
class ImageProcessService{


  void pickFile()async{
    FilePickerResult? res=await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png','jpg','jpeg'],
      allowMultiple: false,
    );
    if(res !=null){
      file=File(res.files.first.path??'');
    }
  }

  // Future<double> processFile()async{
  //   double res=0.0;
  //   if(file.path.isEmpty){
  //     throw Exception("Pick file first");
  //   }
  //
  //   FlutterVision vision=FlutterVision();
  //
  //
  //   return res;
  // }


  Future<double> calculateClarityPercentage() async {
    // Get image dimensions
    File image = File(file.path);
    final decodedImage = await decodeImageFromList(image.readAsBytesSync());

    // Calculate clarity percentage (for example, based on image resolution)
    double clarityPercentage = ((decodedImage.width * decodedImage.height) / (1920 * 1080)) * 100;

    return clarityPercentage.clamp(0.0, 100.0); // Clamp between 0% and 100%
  }

 /* Future<double> calculateImageClarity(Image image) async {
    final processor = ImageProcessor();
    final sharpnessScore = await processor.sharpness(image);
    final brightnessScore = await processor.brightness(image);
    final contrastScore = await processor.contrast(image);
    final clarityScore = (sharpnessScore + brightnessScore + contrastScore) / 3;
    return clarityScore;
  }*/


  double calculateSharpness(Uint8List imageData) {
    img.Image image = img.decodeImage(imageData)!;

    // Convert image to grayscale
    img.Image grayscale = img.grayscale(image);

    // Apply Laplacian filter
    img.Image laplacian = laplacianFilter(grayscale);

    // Compute variance of the Laplacian
    double variance = _computeVariance(laplacian);

    // Return the computed sharpness score
    return variance;
  }

  double _computeVariance(img.Image image) {
    // Compute mean of the image
    double mean = 0.0;
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        mean += image.getPixel(x, y) & 0xFF; // Assuming grayscale, extract brightness value
      }
    }
    mean /= (image.width * image.height);

    // Compute variance
    double variance = 0.0;
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        double pixel = (image.getPixel(x, y) & 0xFF).toDouble();
        variance += ((pixel - mean) * (pixel - mean));
      }
    }
    variance /= (image.width * image.height);

    return variance;
  }


  img.Image laplacianFilter(img.Image grayscale) {
    List<List<int>> laplacianKernel = [
      [0, 1, 0],
      [1, -4, 1],
      [0, 1, 0],
    ];

    img.Image result = img.Image(height: grayscale.height, width: grayscale.width);

    for (int y = 1; y < grayscale.height - 1; y++) {
      for (int x = 1; x < grayscale.width - 1; x++) {
        double sum = 0;
        for (int dy = -1; dy <= 1; dy++) {
          for (int dx = -1; dx <= 1; dx++) {
            sum += grayscale.getPixel(x + dx, y + dy) & 0xFF * laplacianKernel[dy + 1][dx + 1];
          }
        }
        int redValue = 255;
        int color = img.getColor(redValue, 0, 0);
        result.setPixel(x, y, color.clamp(0, 255));
        // result.setPixel(x, y, sum.clamp(0, 255));
      }
    }

    return result;
  }




}