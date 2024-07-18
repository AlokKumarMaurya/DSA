import 'dart:convert';

CreateChatRequestModel createChatRequestModelFromJson(String str) =>
    CreateChatRequestModel.fromJson(json.decode(str));

String createChatRequestModelToJson(CreateChatRequestModel data) =>
    json.encode(data.toJson());

class CreateChatRequestModel {
  final int mobileNumber;
  final String message;

  CreateChatRequestModel({
    required this.message,
    required this.mobileNumber,
  });

  factory CreateChatRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateChatRequestModel(
        message: json["message"],
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "mobileNumber": mobileNumber,
        "message": message,
      };
}

