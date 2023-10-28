import 'package:cloud_firestore/cloud_firestore.dart';
import 'dbfields.dart';
class Dbinsert {
  final db = FirebaseFirestore.instance;
  addNewUser(String name, String email, String password,String firstname,String lastname,String username,String phone) async {
    try {
        final user = <String, dynamic>{
        Dbfield.firsntname: firstname,
        Dbfield.lastname: lastname,
        Dbfield.email:email,
        Dbfield.password:password,
        Dbfield.username:username,
        Dbfield.phone:phone
      };
      await db.collection("users").add(user).then((DocumentReference doc) =>
      // ignore: avoid_print
      print('DocumentSnapshot added with ID: ${doc.id}'));
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }

}