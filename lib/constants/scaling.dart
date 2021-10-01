import 'package:flutter/material.dart';

scaling(context, size) {
  double scaleFactor = 1;
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  if (screenWidth / screenHeight >= 1.7) {
    scaleFactor = screenHeight / 360;
  } else if (screenWidth <= 640) {
    scaleFactor = screenWidth / 640;
    if (screenHeight < 360 * scaleFactor) {
      scaleFactor = screenHeight / 360;
    }
  } else if (screenHeight <= 360) {
    scaleFactor = screenHeight / 360;
  } else if (screenHeight >= 480) {
    scaleFactor = screenHeight / 480;
    if (screenWidth / scaleFactor < 640) {
      scaleFactor = screenWidth / 640;
    }
  }
  double newSize = size * scaleFactor;
  var scaledSize = newSize.toDouble();
  print(scaledSize);
  return scaledSize;
}
