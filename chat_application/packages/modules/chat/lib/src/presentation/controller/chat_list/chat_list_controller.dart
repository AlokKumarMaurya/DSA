import 'package:chat_module/src/domain/usecase/chat_useCase/chat_useCase.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_storage/local_storage.dart';
import 'package:network_service/network_service.dart';
import 'package:auth/auth.dart';
import '../../../data/models/response/get_all_chat_list_response.dart';

class ChatListController extends GetxController {
  bool isLoading = false;
  List<GetAllChatListResponse> chatList = [];
  String userPhone = "";
  final ChatUseCase _chatUseCase = Get.find();
  final TextEditingController newChatNumberTextEditingController =
      TextEditingController();

  @override
  void onInit() {
    FirebaseAuth auth = FirebaseAuth.instance;
    userPhone = auth.currentUser!.phoneNumber ?? auth.currentUser?.email ?? "";
    getChatList();
    super.onInit();
  }

  Future<void> getChatList() async {
    return await _chatUseCase
        .getAllChatList(mobileNumber: FirebaseAuth.instance.currentUser!.uid)
        .then(
      (value) {
        chatList = value.chatList;
        update();
        return;
      },
    );
  }
  Stream<List<GetAllChatListResponse>> getChatListStream() async* {
    print("CALLED AGAIN =============  AGAIN");
    yield (await _chatUseCase
        .getAllChatList(mobileNumber: FirebaseAuth.instance.currentUser!.uid)).chatList;
  }

  Future<void> addNewUserToChat({required String number}) async {
    if (number.isEmpty || number.length < 10) return;
    Get.back();
    isLoading=true;
    update();
    bool res=await _chatUseCase.addNewUserToChatList(
      number: number,
      userId: FirebaseAuth.instance.currentUser!.uid,
    );
    if(!res){
      Get.snackbar("Error", "Contact does not exist");
    }
    isLoading=false;
    update();
  }

  void logoutUser() {
    AppLocalStorage().setLoginStatus(isLoggedIn: false);
    Get.offAllNamed(AuthRoutes.authPages.first.name);
  }
}
