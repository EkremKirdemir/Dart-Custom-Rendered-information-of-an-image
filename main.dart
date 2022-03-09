import 'package:exif/exif.dart';
import 'dart:io';

void main() async {
  print(await photoType("assets/IMG_0129.jpeg"));
}

Future<String> photoType(String path) async {
  final fileBytes = File(path).readAsBytesSync();
  final data = await readExifFromBytes(fileBytes);
  print(path.split(".").last);
  int customRenderedCode = 9;
  late String result;
  for (final entry in data.entries) {
    if ("${entry.key}" == 'EXIF CustomRendered') {
      customRenderedCode = int.parse("${entry.value}");
    }
  }
  if (customRenderedCode == 0) {
    result = "Normal";
  } else if (customRenderedCode == 1) {
    result = "Custom";
  } else if (customRenderedCode == 2) {
    result = "HDR (no original saved)";
  } else if (customRenderedCode == 3) {
    result = "HDR (original saved)";
  } else if (customRenderedCode == 4) {
    result = "Original(for HDR";
  } else if (customRenderedCode == 6) {
    result = "Panorama";
  } else if (customRenderedCode == 7) {
    result = "Portrait HDR";
  } else if (customRenderedCode == 8) {
    result = "Protrait";
  } else if (customRenderedCode == 9) {
    result = "Live";
  }
  return Future.delayed(const Duration(seconds: 0), () => result);
}
