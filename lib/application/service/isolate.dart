import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';

void main() async {
  
}

Future<void> getCurrency(SendPort sendPort) async {
  print("ISOLATE ISHGA TUSHDI");
  final httpClient = HttpClient();
  final request = await httpClient
      .getUrl(Uri.parse("https://nbu.uz/uz/exchange-rates/json/"));
  final response = await request.close();
  final data = await response.transform(utf8.decoder).join();
  sendPort.send(data);
}

Future<void> readFile(SendPort sendPort) async {
  final readFile = File('video.mp4');
  Uint8List readContents = await readFile.readAsBytes();
  sendPort.send(readContents);
}
