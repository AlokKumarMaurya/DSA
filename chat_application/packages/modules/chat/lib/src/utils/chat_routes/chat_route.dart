import 'package:network_service/network_service.dart';
import 'chat_route_name.dart';
import '../../presentation/view/chat_list/chat_list_page.dart';
import '../../presentation/controller/chat_list/chat_list_controller.dart';

class ChatRoute {
  static final chatPage = [
    GetPage(
        name: ChatRouteName.chatListScreen,
        page: () => const ChatListPage(),
        binding: BindingsBuilder(() => Get.lazyPut(() => ChatListController())))
  ];
}
