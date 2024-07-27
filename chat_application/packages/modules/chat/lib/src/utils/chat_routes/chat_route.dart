import 'package:chat_module/src/presentation/controller/chat_detail_list/chat_detail_list_controller.dart';
import 'package:chat_module/src/presentation/view/chat_detail_list/chat_detail_list_view.dart';
import 'package:network_service/network_service.dart';
import 'chat_route_name.dart';
import '../../presentation/view/chat_list/chat_list_page.dart';
import '../../presentation/controller/chat_list/chat_list_controller.dart';

class ChatRoute {
  static final chatPage = [
    GetPage(
        name: ChatRouteName.chatListScreen,
        page: () => const ChatListPage(),
        binding: BindingsBuilder(() => Get.lazyPut(() => ChatListController()))),
    GetPage(
        name: ChatRouteName.chatDetailListScreen,
        page: () => const ChatDetailListView(),
        binding: BindingsBuilder(() => Get.lazyPut(() => ChatDetailListController()))),
  ];
}
