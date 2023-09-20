import 'package:dio/dio.dart';
import 'package:tdd/domain/model/telegram_updates_model.dart';

class TelegramService {
  final String _token = "6386305346:AAHeqJFZ4hhDnkBBiinubGiOAnE_C0L9ObI";
  final String _chatId = "-1001876122365";
  
  Future<dynamic> getUpdates() async {
    try {
      Response response =
          await Dio().get("https://api.telegram.org/bot$_token/getUpdates");
      if (response.statusCode == 200) {
        return TelegramChannelModel.fromJson(response.data);
      } else {
        return response.statusMessage.toString();
      }
    } on DioException catch (e) {
      return e.error.toString();
    }
  }

  Future<dynamic> sendMessage(String message) async {
    try {
      final Uri uri = Uri.https('api.telegram.org', '/bot$_token/sendMessage', {
        "chat_id": _chatId,
        "text": {
          "from": "Bekzod",
          "text": message,
          "created_at": DateTime.now().year.toString()
        }.toString()
      });

      await Dio().getUri(uri);
    } on DioException catch (e) {
      return e.error.toString();
    }
  }
}
