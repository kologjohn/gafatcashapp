import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gafatcash/startup/controller/database.dart';
import 'package:gafatcash/startup/controller/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAccounts extends ChangeNotifier{
  final auth=FirebaseAuth.instance;
  bool loginstatus=false;
  String error="";
  bool errorstatus=false;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: "1058517351380-dv787nium22lfaj97f578e1rooa8oduq.apps.googleusercontent.com",
  );


    googlesignup(BuildContext context) async{
     String? name="";

     try{
       final GoogleSignInAccount? googleSignInAccount=await GoogleSignIn().signIn();
       final GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount!.authentication;
       final credentials=GoogleAuthProvider.credential(
           accessToken: googleSignInAuthentication.accessToken,
           idToken: googleSignInAuthentication.idToken
       );
       name=auth.currentUser!.email;
       print(auth.currentUser!.displayName);
       auth.signInWithCredential(credentials);
       if(auth.currentUser!=null)
         {
           Navigator.pushNamed(context, Routes.dashboard);

         }


     }on FirebaseException catch(e){
       name=e.message;
       print(e.message);
     }
     return name!;

    // try{
    //   await googleSignIn.signIn();
    //   print("Test Print${auth.currentUser!.email}");
    //   //await _auth.createUserWithEmailAndPassword(email: email, password: password);
    // }on FirebaseException catch (e){
    //   print(e.message);
    // }
  }




  Future<String> login(String email, String password, BuildContext context) async {
    String errorMsgs="";
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //setpreference("Kolog John", "Zanlerigu", 20, true);
      //Navigator.pushNamed(context, Routes.dashboard);
      loginstatus=true;
    }on FirebaseException catch (e) {
      errorMsgs=e.message!;
      //message="${e.toString()}";
      //print("Can not login $e");
    }
    notifyListeners();
    return errorMsgs;
  }

  Future<String> signup(BuildContext context, String email, String password, String firstname,String lastname,String username, String phone) async {
    String errorMsg="";
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // sharedPreferences.setBool("name", true);
      // sharedPreferences.setString("phone", phone);
      await Dbinsert().addNewUser(username, email, password, firstname, lastname, username,phone);
      errorstatus=true;
      //Navigator.pushNamed(context, Routes.dashboard);
    } on FirebaseAuthException catch (e) {
      errorMsg=e.message.toString();
      errorstatus=false;
      // print("Can Not Create Account $e");
    }
    notifyListeners();
    return errorMsg;
  }

  Future<void> logout(BuildContext context)  async {
    try {
      await auth.signOut().whenComplete(() => print("Logout Successfully"));
     Navigator.popAndPushNamed(context,Routes.login);
    } catch (e) {
      print("Error Signing Out $e");
    }
  }

  // Future innitial(BuildContext context) async {
  //   final user = await auth.currentUser;
  //   if (user != null) {
  //     //print("Already Login ${user.email}");
  //     //Navigator.pushNamed(context, Routes.dashboard);
  //   }
  //   notifyListeners();
  // }

  sessions<List>(String nametxt, int agetxt, String hometowntxt) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.get("status");
    // loginstatus = sharedPreferences.getBool("status")!;
    // nametxt = sharedPreferences.getString("name")!;
    // agetxt = sharedPreferences.getInt("age")!;
    // hometowntxt = sharedPreferences.getString("home")!;
    // hometown=sharedPreferences.getString("hometown")!;
    notifyListeners();
    return [nametxt, agetxt, hometowntxt, loginstatus];
  }

  Future<void> setpreference(String nametxt, String hometowntxt, int agenum, bool status) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setBool("status", status);
    // sharedPreferences.setInt("age", agenum);
    // sharedPreferences.setString("name", nametxt);
    // sharedPreferences.setString("home", hometowntxt);
    // notifyListeners();
  }


}