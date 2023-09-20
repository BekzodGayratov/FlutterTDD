class TelegramChannelModel {
  bool? ok;
  List<Result>? result;

  TelegramChannelModel({this.ok, this.result});

  TelegramChannelModel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? updateId;
  ChannelPost? channelPost;

  Result({this.updateId, this.channelPost});

  Result.fromJson(Map<String, dynamic> json) {
    updateId = json['update_id'];
    channelPost = json['channel_post'] != null
        ? new ChannelPost.fromJson(json['channel_post'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['update_id'] = this.updateId;
    if (this.channelPost != null) {
      data['channel_post'] = this.channelPost!.toJson();
    }
    return data;
  }
}

class ChannelPost {
  int? messageId;
  SenderChat? senderChat;
  SenderChat? chat;
  int? date;
  String? text;

  ChannelPost(
      {this.messageId, this.senderChat, this.chat, this.date, this.text});

  ChannelPost.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    senderChat = json['sender_chat'] != null
        ? new SenderChat.fromJson(json['sender_chat'])
        : null;
    chat = json['chat'] != null ? new SenderChat.fromJson(json['chat']) : null;
    date = json['date'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message_id'] = this.messageId;
    if (this.senderChat != null) {
      data['sender_chat'] = this.senderChat!.toJson();
    }
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    data['date'] = this.date;
    data['text'] = this.text;
    return data;
  }
}

class SenderChat {
  int? id;
  String? title;
  String? type;

  SenderChat({this.id, this.title, this.type});

  SenderChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}
