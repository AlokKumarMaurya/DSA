







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





class Profile {
  final String id;
  final String name;
  final String phoneNumber;

  Profile({
    required this.name,
    required this.phoneNumber,
    required this.id,
  });

  Profile copyWith({String? name, String? phoneNumber}) => Profile(
        id: id,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        name: name ?? this.name,
      );

  factory Profile.fromJson(Map<Object?, dynamic> json) => Profile(
        id: json['id'],
        phoneNumber: json["phoneNumber"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
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


class Message {
  final int id;
  final String msg;
  final int time;
  final String senderId;
  final bool isRead;

  Message({
    required this.id,
    required this.msg,
    required this.time,
    required this.senderId,
    required this.isRead,
  });

  Message copyWith({
    String? msg,
    int? time,
    String? senderId,
    bool? isRead,
  }) =>
      Message(
        id: id,
        msg: msg ?? this.msg,
        time: time ?? this.time,
        senderId: senderId ?? this.senderId,
        isRead: isRead ?? this.isRead,
      );

  factory Message.fromJson(Map<Object?, dynamic> json) => Message(
    id: json['id'],
    msg: json["msg"],
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
  };
}
