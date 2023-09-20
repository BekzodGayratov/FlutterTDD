import 'package:flutter/material.dart';
import 'package:tdd/domain/model/telegram_updates_model.dart';
import 'package:tdd/domain/services/remote/telegram_service.dart';

class TelegramUpdatePage extends StatelessWidget {
  TelegramUpdatePage({super.key});
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Telegram Bot"),
      ),
      body: FutureBuilder(
          future: TelegramService().getUpdates(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.data is String) {
              return Center(
                child: Text(snapshot.data.toString()),
              );
            } else {
              var data = snapshot.data as TelegramChannelModel;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data.result![index].channelPost!.text.toString()),
                  );
                },
                itemCount: data.result!.length,
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: TextFormField(
        controller: _messageController,
        decoration: InputDecoration(
            hintText: "Send a messsage",
            suffixIcon: IconButton(
                onPressed: () async {
                  TelegramService()
                      .sendMessage(_messageController.text)
                      .then((value) {
                    _messageController.clear();
                  });
                },
                icon: const Icon(Icons.send))),
      ),
    );
  }
}
