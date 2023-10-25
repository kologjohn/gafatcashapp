import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAccounts extends ChangeNotifier{
  final _auth=FirebaseAuth.instance;

  Future<void> signup(String email,String password) async{

    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }catch (e){
      print(e);
    }



  }

}