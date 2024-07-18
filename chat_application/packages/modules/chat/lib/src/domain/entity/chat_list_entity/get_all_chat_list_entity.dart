import 'package:network_service/network_service.dart';

class GetAllChatListEntity extends BaseEntity{
  List<AllChatListEntity> chatList;
  GetAllChatListEntity({required super.message,required this.chatList});

}



class AllChatListEntity{
  final String name;
  final String profileUrl;
  final String lastChat;

  AllChatListEntity({required this.name, required this.profileUrl, required this.lastChat});
}