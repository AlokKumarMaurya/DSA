import 'package:auth/src/email_password/email_password.dart';
import 'package:auth/src/email_password/email_password_controller.dart';
import 'package:auth/src/google/google_auth.dart';
import 'package:auth/src/google/google_auth_controller.dart';
import 'package:network_service/network_service.dart';

import '../phone/phone_auth.dart';
import '../phone/phone_auth_controller.dart';
import '../view/login/login.dart';
import 'auth_page_name.dart';

class AuthRoutes {
  static final authPages = [
    GetPage(
      name: AuthPageName.login,
      page: () => const Login(),
    ),
    GetPage(
        name: AuthPageName.phoneAuth,
        page: () => const PhoneAuth(),
        binding:
            BindingsBuilder(() => Get.lazyPut(() => PhoneAuthController()))),
    GetPage(
        name: AuthPageName.googleAuth,
        page: () => const GoogleAuth(),
        binding:
            BindingsBuilder(() => Get.lazyPut(() => GoogleAuthController()))),
    GetPage(
        name: AuthPageName.emailAndPassword,
        page: () => const EmailPassword(),
        binding: BindingsBuilder(
            () => Get.lazyPut(() => EmailPasswordController()))),
  ];
}
