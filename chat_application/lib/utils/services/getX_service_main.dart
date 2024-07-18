import 'package:chat_application/utils/class_importer.dart';
import 'package:firebase_service/firebase_service.dart';

import '../logger/logger.dart';

class GetXServiceMain extends GetxService{
  @override
  void onInit() {
    Logger.log(mes: "Initialing the GetX Main Service");
   //initialize the firebase
    FirebaseService.init();
    super.onInit();
  }
}