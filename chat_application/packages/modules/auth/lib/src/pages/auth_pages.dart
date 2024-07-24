import 'package:network_service/network_service.dart';

import '../phone/phone_auth.dart';
import '../phone/phone_auth_controller.dart';
import 'auth_page_name.dart';

class AuthRoutes {
  static final authPages = [
    GetPage(
        name: AuthPageName.phoneAuth,
        page: () => const PhoneAuth(),
        binding:
            BindingsBuilder(() => Get.lazyPut(() => PhoneAuthController())))
  ];
}
