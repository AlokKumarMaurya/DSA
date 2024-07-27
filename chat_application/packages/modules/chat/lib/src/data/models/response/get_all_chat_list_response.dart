import 'package:network_service/network_service.dart';
class GetAllChatListResponse {
  final String lastMessage;
  final int lastMessageTime;
  final SenderDetail senderDetail;

  GetAllChatListResponse({
    required this.senderDetail,
    required this.lastMessageTime,
    required this.lastMessage,
  });

  GetAllChatListResponse copyWith({
    String? lastMessage,
    SenderDetail? senderDetail,
    int? lastMessageTime,
  }) =>
      GetAllChatListResponse(
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
        senderDetail: senderDetail ?? this.senderDetail,
        lastMessage: lastMessage ?? this.lastMessage,
      );

  factory GetAllChatListResponse.fromJson(Map<Object?, dynamic> json) =>
      GetAllChatListResponse(
        lastMessageTime:
            List<Message>.from(json["messages"].map((x) => Message.fromJson(x)))
                .last
                .time,
        senderDetail: SenderDetail.fromJson(json["Sender-Detail"]),
        lastMessage:
            List<Message>.from(json["messages"].map((x) => Message.fromJson(x)))
                .last
                .msg,
      );
}
