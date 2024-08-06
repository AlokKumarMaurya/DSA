import 'package:network_service/network_service.dart';
class GetAllChatListResponse {
  final String id;
  final String lastMessage;
  final int lastMessageTime;
  final SenderDetail senderDetail;
  final SenderDetail receiverDetail;

  GetAllChatListResponse({
    required this.id,
    required this.senderDetail,
    required this.receiverDetail,
    required this.lastMessageTime,
    required this.lastMessage,
  });

  GetAllChatListResponse copyWith({
    String? lastMessage,
    SenderDetail? senderDetail,
    SenderDetail? receiverDetail,
    int? lastMessageTime,
  }) =>
      GetAllChatListResponse(
        id: id,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
        senderDetail: senderDetail ?? this.senderDetail,
        receiverDetail: receiverDetail ?? this.receiverDetail,
        lastMessage: lastMessage ?? this.lastMessage,
      );

  factory GetAllChatListResponse.fromJson(Map<Object?, dynamic> json) =>
      GetAllChatListResponse(
        id: json["id"],
        lastMessageTime:
            List<Message>.from(json["messages"].map((x) => Message.fromJson(x)))
                .last
                .time,
        senderDetail: SenderDetail.fromJson(json["Sender-Detail"]),
        receiverDetail: SenderDetail.fromJson(json["receiverDetail"]),
        lastMessage:
            List<Message>.from(json["messages"].map((x) => Message.fromJson(x)))
                .last
                .msg,
      );
}
