import 'package:network_service/network_service.dart';

import '../../../data/models/response/get_all_chat_list_response.dart';

class GetAllChatListEntity extends BaseEntity{
  List<GetAllChatListResponse> chatList;
  GetAllChatListEntity({required super.message,required this.chatList});

}


