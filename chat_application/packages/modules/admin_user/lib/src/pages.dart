import 'package:admin_user/src/screens/demo/demo_UI.dart';
import 'package:admin_user/src/screens/demo/demo_controller.dart';
import 'package:network_service/network_service.dart';

class AdminRoutes {
  static final adminPages = [
    GetPage(
        name: AdminRouteName.demoPage,
        page: () => const DemoUi(),
        binding: BindingsBuilder(() => Get.lazyPut(() => DemoController())))
  ];
}


class AdminRouteName{
  static const String demoPage="/demoPage";
}