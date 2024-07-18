// To parse this JSON data, do
//
//     final getAllChatListResponse = getAllChatListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_module/src/domain/entity/chat_list_entity/get_all_chat_list_entity.dart';
import 'package:network_service/network_service.dart';

List<GetAllChatListResponse> getAllChatListResponseFromJson(String str) =>
    List<GetAllChatListResponse>.from(
        json.decode(str).map((x) => GetAllChatListResponse.fromJson(x)));

String getAllChatListResponseToJson(List<GetAllChatListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllChatListResponse extends BaseResponse {
  final int age;
  final String lastMessage;
  final List<Chat> chats;
  final String email;
  final String name;
  final String profilePhoto;

  GetAllChatListResponse({
    required this.chats,
    required this.age,
    required this.email,
    required this.name,
    required this.profilePhoto,
    required this.lastMessage,
  });

  factory GetAllChatListResponse.fromJson(Map<String, dynamic> json) =>
      GetAllChatListResponse(
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
        age: json["age"],
        lastMessage: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x)))
            .last
            .message,
        email: json["email"],
        name: json["name"],
        profilePhoto: json["profile_photo"],
      );

  Map<String, dynamic> toJson() => {
        "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
        "age": age,
        "email": email,
        "name": name,
        "profile_photo": profilePhoto,
      };

  @override
  toEntity(dynamic str) {
    return GetAllChatListEntity(
        message: "Chat List Get Successful",
        chatList: getAllChatListResponseFromJson(str)
            .map(
              (e) => AllChatListEntity(
                name: e.name,
                profileUrl: e.profilePhoto,
                lastChat: e.chats.last.message,
              ),
            )
            .toList());
  }
}

class Chat {
  final String message;
  final int time;

  Chat({
    required this.message,
    required this.time,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        message: json["message"]!,
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "time": time,
      };
}
