import 'package:chat_application/utils/class_importer.dart';

import '../logger/logger.dart';

class GetXServiceMain extends GetxService{
  @override
  void onInit() {
    Logger.log(mes: "Initialing the GetX Main Service");
    super.onInit();
  }
}