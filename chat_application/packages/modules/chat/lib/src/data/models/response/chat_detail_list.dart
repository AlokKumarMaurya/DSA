
import 'dart:convert';

ChatDetailListResponseModel chatDetailListResponseModelFromJson(String str) => ChatDetailListResponseModel.fromJson(json.decode(str));

String chatDetailListResponseModelToJson(ChatDetailListResponseModel data) => json.encode(data.toJson());

class ChatDetailListResponseModel {
  final String name;
  final String email;
  final String profilePhoto;
  final int age;
  final List<Chat> chats;

  ChatDetailListResponseModel({
    required this.name,
    required this.email,
    required this.profilePhoto,
    required this.age,
    required this.chats,
  });

  factory ChatDetailListResponseModel.fromJson(Map<String, dynamic> json) => ChatDetailListResponseModel(
    name: json["name"],
    email: json["email"],
    profilePhoto: json["profile_photo"],
    age: json["age"],
    chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "profile_photo": profilePhoto,
    "age": age,
    "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
  };
}

class Chat {
  final String message;
  final int time;

  Chat({
    required this.message,
    required this.time,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    message: json["message"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "time": time,
  };
}
