import 'package:firebase_database/firebase_database.dart';

class CreateDb {
  Future<bool> createCollection(
      {required String userID, required String message}) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref(userID);

    databaseReference.set([{
      'name': 'John Doe1111',
      'email': 'johndoe@example.com',
      "profile_photo": "https//data.com",
      'age': 30,
      'chats': [
        {'message': 'hello', 'time': DateTime.now().microsecondsSinceEpoch},
        {'message': 'hello', 'time': DateTime.now().microsecondsSinceEpoch},
        {'message': 'hello', 'time': DateTime.now().microsecondsSinceEpoch},
        {'message': 'hello', 'time': DateTime.now().microsecondsSinceEpoch},
        {'message': 'hello', 'time': DateTime.now().microsecondsSinceEpoch},
      ]
    },{
      'name': 'John Doe3333',
      'email': 'johndoe@example.com',
      "profile_photo": "https//data.com",
      'age': 30,
      'chats': [
        {'message': 'hello', 'time': DateTime.now().microsecondsSinceEpoch},
        {'message': 'hello', 'time': DateTime.now().microsecondsSinceEpoch},
        {'message': 'hello', 'time': DateTime.now().microsecondsSinceEpoch},
        {'message': 'hello', 'time': DateTime.now().microsecondsSinceEpoch},
        {'message': 'hello', 'time': DateTime.now().microsecondsSinceEpoch},
        {'message': 'hello', 'time': DateTime.now().microsecondsSinceEpoch},
      ]
    }]);



    DatabaseReference starCountRef =
    FirebaseDatabase.instance.ref(userID);
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
    });

    return true;
  }
}
