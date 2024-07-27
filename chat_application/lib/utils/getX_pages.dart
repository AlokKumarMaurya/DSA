import 'package:admin_user/admin_user.dart';
import 'package:auth/auth.dart';
import 'package:chat_application/utils/class_importer.dart';
import 'package:chat_module/chat.dart';
import 'package:local_storage/get_storage/get_storage.dart';

class GetXPages {
  static final List<GetPage> appRoutes = [
    ...ChatRoute.chatPage,
    ...AdminRoutes.adminPages,
    ...AuthRoutes.authPages
  ];

  static String initialRoute() {
    // return AdminRoutes.adminPages.first.name;
    if (AppLocalStorage().isLoggedIn()) {
      return ChatRoute.chatPage.first.name;
    }
    return AuthRoutes.authPages.first.name;
  }
}
