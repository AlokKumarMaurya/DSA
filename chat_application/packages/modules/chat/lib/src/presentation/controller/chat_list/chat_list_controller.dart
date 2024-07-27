import 'package:chat_module/src/domain/usecase/chat_useCase/chat_useCase.dart';
import 'package:network_service/network_service.dart';
import 'package:auth/auth.dart';
import '../../../data/models/response/get_all_chat_list_response.dart';
class ChatListController extends GetxController {
  bool isLoading = false;
  List<GetAllChatListResponse> chatList = [];
String userPhone="";
  final ChatUseCase _chatUseCase = Get.find();

  @override
  void onInit() {
    FirebaseAuth auth = FirebaseAuth.instance;
    userPhone=auth.currentUser!.phoneNumber??"";
    getChatList();
    super.onInit();
  }

  Future<void> getChatList() async {
  return await _chatUseCase.getAllChatList(mobileNumber: userPhone).then(
      (value) {
        chatList = value.chatList;
        update();
        return ;
      },
    );
  }
}
