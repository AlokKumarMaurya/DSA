







class SenderDetail {
  final String name;
  final String phoneNumber;
  final String id;
  final String fcmToken;

  SenderDetail({
    required this.name,
    required this.phoneNumber,
    required this.fcmToken,
    required this.id,
  });

  SenderDetail copyWith({
    String? name,
    String? phoneNumber,
  }) =>
      SenderDetail(
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        id: id ,
        fcmToken: fcmToken ,
      );

  factory SenderDetail.fromJson(Map<Object?, dynamic> json) => SenderDetail(
        name: json["name"],
        phoneNumber: json["phoneNumber"],
    fcmToken: json["fcmToken"],
    id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "fcmToken": fcmToken,
        "phoneNumber": phoneNumber,
        "id": id,
      };
}





class Profile {
  final String id;
  final String name;
  final String phoneNumber;
  final String fcmToken;

  Profile({
    required this.name,
    required this.phoneNumber,
    required this.id,
    required this.fcmToken,
  });

  Profile copyWith({String? name, String? phoneNumber}) => Profile(
        id: id,
    fcmToken: fcmToken,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        name: name ?? this.name,
      );

  factory Profile.fromJson(Map<Object?, dynamic> json) => Profile(
        id: json['id'],
    fcmToken: json['fcmToken'],
        phoneNumber: json["phoneNumber"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fcmToken': fcmToken,
        "name": name,
        "phoneNumber": phoneNumber,
      };
}

class UserChats {
  final String userId;
  final List<String> chatId;

  UserChats({required this.userId, required this.chatId});

  factory UserChats.fromJson(Map<Object?, dynamic> json) => UserChats(
        userId: json['userId'],
        chatId: json["chatId"],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        "chatId": chatId,
      };
}






class MessageWithDetail {
  final List<Message> messages;
  final SenderDetail senderDetail;
  final SenderDetail receiverDetail;

  MessageWithDetail({
    required this.messages,
    required this.senderDetail,
    required this.receiverDetail,
  });



  factory MessageWithDetail.fromJson(Map<Object?, dynamic> json) => MessageWithDetail(
    messages: json['messages'],
    senderDetail: json["senderDetail"],
    receiverDetail: json["receiverDetail"],
  );

  Map<String, dynamic> toJson() => {
    'messages': messages,
    "senderDetail": senderDetail,
    "receiverDetail": receiverDetail,
  };
}




class Message {
  final int id;
  final String msg;
  final int time;
  final String senderId;
  final String receiverId;
  final bool isRead;

  Message({
    required this.id,
    required this.msg,
    required this.time,
    required this.senderId,
    required this.receiverId,
    required this.isRead,
  });

  Message copyWith({
    String? msg,
    int? time,
    bool? isRead,
  }) =>
      Message(
        receiverId: receiverId,
        senderId: senderId,
        time: time??this.time,
        id: id,
        msg: msg ?? this.msg ,
        isRead: isRead ?? this.isRead,
      );

  factory Message.fromJson(Map<Object?, dynamic> json) => Message(
    id: json['id'],
    msg: json["msg"],
    receiverId: json["receiverId"],
    time: json["time"],
    senderId: json["senderId"],
    isRead: json["isRead"],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    "msg": msg,
    "time": time,
    "senderId": senderId,
    "isRead": isRead,
    "receiverId": receiverId,
  };
}
