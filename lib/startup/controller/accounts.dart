import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAccounts extends ChangeNotifier{
  final _auth=FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    hostedDomain: "gafatcashapp-6c45f.firebaseapp.com",

    clientId: "AIzaSyBypUEdN1PXwEc35IdIt-cv8dnRIz1RAx0",
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Future<void> signup(String email,String password) async{

    try{
      _googleSignIn.signIn();
      //await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }catch (e){
      print(e);
    }



  }

}