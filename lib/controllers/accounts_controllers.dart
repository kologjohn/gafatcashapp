import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
class FirebaseAccounts extends ChangeNotifier{
  static String ?current_username;
  static String ?user_email;
   String ?error;
   bool status=false;
  final _auth= FirebaseAuth.instance;

  Future<void> crateaccount(String email,String password,String phone,String username,String firstname,String lastname) async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseException catch(e){
      error=e.message;
      status=true;
    }
    notifyListeners();
  }
   login(String email,password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      error=e.message;
      status=true;
    }
    notifyListeners();

  }


}
