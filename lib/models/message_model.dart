
class ChatListDateWise {
  String? dateTime;
  List<ChatListModel>? chat;

  ChatListDateWise(
      {
        this.dateTime,
        this.chat}
      );

  ChatListDateWise.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    if (json['chat'] != null) {
      chat = <ChatListModel>[];
      json['chat'].forEach((v) {
        chat!.add(ChatListModel.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateTime'] = dateTime;
    if (chat != null) {
      data['chat'] = chat!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}




class ChatListModel {
  String? message;
  String? time;
  bool? isReceiver;

  ChatListModel(
      {
        this.message,
        this.isReceiver,
        this.time,}
       );

  ChatListModel.fromJson(Map<String, dynamic> json) {
    isReceiver = json['isReceiver'];
    message = json['message'];
    time = json['time'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isReceiver'] = isReceiver;
    data["message"] = message;
    data['time'] = time;

    return data;
  }
}
