import 'package:chat_application/utils/class_importer.dart';
import 'package:chat_application/utils/services/getX_service_main.dart';

import '../logger/logger.dart';

class InjectGetXControllers {
  static final InjectGetXControllers _injectGetXControllers =
      InjectGetXControllers._internal();

  InjectGetXControllers._internal() {
    Logger.log(mes: "Injecting GetX-Controllers");
    Get.put(GetXServiceMain());
  }

  factory InjectGetXControllers() {
    return _injectGetXControllers;
  }
}
