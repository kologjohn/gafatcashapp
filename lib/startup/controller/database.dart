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
  //new Records
   sendmoney(String email, String phone,String tocountry,String from,double send,double get,String recinumber, reciname,String reason,String recipientphone,String rcurrency,String sendercurrency,String momotype,recipeintbank) async {
    final year=DateTime.now().year;
    final month=DateTime.now().month;
    final day=DateTime.now().day;
    final dayname=DateTime.now().weekday;
    final timestamp=DateTime.timestamp().millisecondsSinceEpoch;
    String date="$year-$month-$day";
    try {
      final user = {
        Dbfield.email: email,
        Dbfield.phone: phone,
        Dbfield.tocountry:tocountry,
        Dbfield.fromcountry:from,
        Dbfield.sendamount:send,
        Dbfield.getamount:get,
        Dbfield.receipientphone:recipientphone,
        Dbfield.reciname:reciname,
        Dbfield.reason:reason,
        Dbfield.receivecurrency:rcurrency,
        Dbfield.sendcurrency:sendercurrency,
        Dbfield.status:"pending",
        Dbfield.date:date,
        Dbfield.tid:timestamp,
        Dbfield.day:day,
        Dbfield.month:month,
        Dbfield.year:year,
        Dbfield.momotype:momotype,
        Dbfield.recipeintbank:recipeintbank
        };
      await db.collection("sendmoney").add(user).then((DocumentReference doc) =>
      // ignore: avoid_print
      print('DocumentSnapshot added with ID: ${doc.id}')

      );
      return "Saved";

      // ignore: empty_catches
    }catch (e) {
      print(e);
      return e;
    }
  }

}