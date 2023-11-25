import 'package:cloud_firestore/cloud_firestore.dart';
import 'dbfields.dart';
class Dbinsert {
  final db = FirebaseFirestore.instance;
  final timestamp=DateTime.timestamp().millisecondsSinceEpoch;
  addNewUser(String name, String email, String password,String firstname,String lastname,String username,String phone) async {
    try {
        final user = <String, dynamic>{
        Dbfield.firsntname: firstname,
        Dbfield.lastname: lastname,
        Dbfield.email:email,
        Dbfield.password:password,
        Dbfield.username:username,
        Dbfield.phone:phone,
        Dbfield.date:timestamp
      };
      await db.collection("users").doc(email).set(user);
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }
  sendmessage(String message,String sender,String recipient,String messagetype)
  {
    final data={Dbfield.message:message,Dbfield.sender:sender,Dbfield.recipient:recipient,Dbfield.messagetype:messagetype,Dbfield.tid:timestamp};
    try{
      db.collection("messages").add(data);
      print("Data Assed");

    }on FirebaseException catch(e){
      print(e.message);
    }
  }




  chatroom(String sendder,String recipient)
  {
    final data={Dbfield.email:sendder,Dbfield.tid:timestamp,Dbfield.recipient:recipient};
    try{
      db.collection("chatroom").doc(sendder).set(data);
      print("Chat Room Created");

    }on FirebaseException catch(e){
      print(e.message);
    }
  }
  //new Records
   sendmoney(String paymode,String reference,String image,String email, String phone,String tocountry,String from,double send,double get,String recinumber, reciname,String reason,String recipientphone,String rcurrency,String sendercurrency,String momotype,recipeintbank) async {
    final year=DateTime.now().year;
    final month=DateTime.now().month;
    final day=DateTime.now().day;
    final dayname=DateTime.now().weekday;
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
        Dbfield.recipeintbank:recipeintbank,
        Dbfield.image:image,
        Dbfield.reference:reference,
        Dbfield.paymode:paymode
        };
      await db.collection("sendmoney").add(user);
      //.then((DocumentReference doc) =>
      // ignore: avoid_print
      //print('DocumentSnapshot added with ID: ${doc.id}')

     // );
      return "Saved";

      // ignore: empty_catches
    }catch (e) {
      print(e);
      return e;
    }
  }

}