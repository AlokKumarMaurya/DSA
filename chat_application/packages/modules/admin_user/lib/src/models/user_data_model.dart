// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  final String profile;
  final List<ChatList> chatList;

  Users({
    required this.profile,
    required this.chatList,
  });

  Users copyWith({
    String? profile,
    List<ChatList>? chatList,
  }) =>
      Users(
        profile: profile ?? this.profile,
        chatList: chatList ?? this.chatList,
      );

  factory Users.fromJson(Map<Object?, dynamic> json) => Users(
    profile: json["Profile"],
    chatList: List<ChatList>.from(json["Chat-List"].map((x) => ChatList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Profile": profile,
    "Chat-List": List<dynamic>.from(chatList.map((x) => x.toJson())),
  };
}

class ChatList {
  final SenderDetail senderDetail;
  final List<Message> messages;

  ChatList({
    required this.senderDetail,
    required this.messages,
  });

  ChatList copyWith({
    SenderDetail? senderDetail,
    List<Message>? messages,
  }) =>
      ChatList(
        senderDetail: senderDetail ?? this.senderDetail,
        messages: messages ?? this.messages,
      );

  factory ChatList.fromJson(Map<Object?, dynamic> json) => ChatList(
    senderDetail: SenderDetail.fromJson(json["Sender-Detail"]),
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Sender-Detail": senderDetail.toJson(),
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

class Message {
  final String msg;
  final int time;
  final bool isByMe;
  final bool isRead;

  Message({
    required this.msg,
    required this.time,
    required this.isByMe,
    required this.isRead,
  });

  Message copyWith({
    String? msg,
    int? time,
    bool? isByMe,
    bool? isRead,
  }) =>
      Message(
        msg: msg ?? this.msg,
        time: time ?? this.time,
        isByMe: isByMe ?? this.isByMe,
        isRead: isRead ?? this.isRead,
      );

  factory Message.fromJson(Map<Object?, dynamic> json) => Message(
    msg: json["msg"],
    time: json["time"],
    isByMe: json["isByMe"],
    isRead: json["isRead"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "time": time,
    "isByMe": isByMe,
    "isRead": isRead,
  };
}



class SenderDetail {
  final String name;
  final int phoneNumber;
  final String profileUrl;

  SenderDetail({
    required this.name,
    required this.phoneNumber,
    required this.profileUrl,
  });

  SenderDetail copyWith({
    String? name,
    int? phoneNumber,
    String? profileUrl,
  }) =>
      SenderDetail(
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profileUrl: profileUrl ?? this.profileUrl,
      );

  factory SenderDetail.fromJson(Map<Object?, dynamic> json) => SenderDetail(
    name: json["name"],
    phoneNumber: json["phone_number"],
    profileUrl: json["profile_url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone_number": phoneNumber,
    "profile_url": profileUrl,
  };
}

