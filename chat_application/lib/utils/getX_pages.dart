import 'package:chat_application/utils/class_importer.dart';
import 'package:chat_module/chat.dart';

class GetXPages {
  static final List<GetPage> appRoutes = [...ChatRoute.chatPage,];

  static String initialRoute() {
    return ChatRoute.chatPage.first.name;
  }
}
