library firebase_service;


export 'package:firebase_database/firebase_database.dart';

import 'package:firebase_core/firebase_core.dart' ;
import 'package:firebase_service/src/create_database/create_db.dart';
import 'package:firebase_service/src/firebase_options.dart';

///Firebase service call
///call FirebaseService.init(); to initialize the firebase
class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  static void init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,

    );
    return;
  }

  void createDB({required String collectionName}){
    CreateDb().createCollection(message: "Demo",userID: "ALOK");
  }


   Future<dynamic> getRealTimeDataBaseTableData({required String tableName})async{

  }

}
