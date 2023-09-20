import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tdd/domain/services/local/crypto_service.dart';

class VideoDownloaderService {
  Future<String> downloadVideo() async {
    try {
      var dir = await getTemporaryDirectory();
      String savePath = '${dir.path}/video.mp4';

      final videoFile = File(savePath);
      debugPrint(videoFile.path);
      List<int> bytes = await videoFile.readAsBytes();
      String videoSegments = String.fromCharCodes(bytes);
      String encryptedFile = CryptoService.encrypt(videoSegments);

      //
      Response response = await Dio().download(
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
          savePath);
      debugPrint(response.statusCode.toString());
      String vSegments = CryptoService.decrypt(encryptedFile);
      List<int> dBytes = vSegments.codeUnits;
      String sPath = '${dir.path}/video.mp4';
      File f = File(sPath);
      await f.writeAsBytes(dBytes);

      return f.path;
    } on DioException catch (e) {
      debugPrint(e.error.toString());
      rethrow;
    }
  }
}
