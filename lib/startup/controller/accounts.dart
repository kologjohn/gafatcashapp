import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gafatcash/startup/controller/database.dart';
import 'package:gafatcash/startup/controller/dbfields.dart';
import 'package:gafatcash/startup/controller/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
class FirebaseAccounts extends ChangeNotifier{
  String session_email="";
  String session_name="";
  String session_phone="";
  bool googlebtn=false;

   var auth=FirebaseAuth.instance;
   final storageRef = FirebaseStorage.instance.ref();
   ImagePicker imagePicker = ImagePicker();
   File? file;
   String imageUrl="";

   bool loginstatus=false;
   String error="";
   bool errorstatus=false;
   List<String> banks=[];
   List bankscode=[];
   var country=["Send to ?"];
   String errorMsgs="";

   //account detail prpperties
   String accountnotfoundtxt="";
   bool matched=false;
   String accname="";
   String momotype="";
   //file upload properties
   FilePickerResult? result;
   PlatformFile? platformFile;
   File? pickedfile;
   String base64="";
   String? filename;
   String? base64Image;
   bool isloading=true;
   final GoogleSignIn _googleSignIn = GoogleSignIn(
     scopes: [
       'email',
       'https://www.googleapis.com/auth/contacts.readonly',
     ],
   );
   String connectionType="";
   Future<UserCredential> signInWithGoogle() async {
     // Create a new provider
     GoogleAuthProvider googleProvider = GoogleAuthProvider();
     googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
     googleProvider.setCustomParameters({
       'login_hint': 'user@example.com'
     });

      final sigin=await auth.signInWithPopup(googleProvider);
      print(auth.currentUser!.email);
      return sigin ;
   }
   googlesignup(BuildContext context) async{
     final GoogleSignInAccount? googleSignInAccount=await GoogleSignIn().signIn();
     final GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount!.authentication;
     final credentials=GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);
     try{
         await  auth.signInWithCredential(credentials);
         loginstatus=true;
         String? name=auth.currentUser!.displayName;
         String? email=auth.currentUser!.email;
         final existdata=await Dbinsert().db.collection("users").doc(email).get();
         if(existdata.exists)
           {
             String phone=existdata.data()!['phone'];
             await setsession(name!, email!, phone);
             if(await SessionManager().containsKey("pin"))
               {
                 Navigator.pushNamed(context, Routes.pinscreen);

               }
             else
               {
                 Navigator.pushNamed(context, Routes.pinsetup);

               }
           }
         else
           {
             googlebtn=true;
            await SessionManager().set("googlebtn", true);
             Navigator.pushNamed(context, Routes.signup);
           }


        // setsession(name!, email!);
         notifyListeners();
     }on FirebaseException catch(e){
       errorMsgs=e.message!;
     }
     notifyListeners();
  }
   Future<String> login(String email, String password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      print("Auth. ${auth.currentUser!.emailVerified}");
      if(!auth.currentUser!.emailVerified)
        {
          errorMsgs="Please Verify Your Account. Check in your email inbox";
        }
      else {
        final existdata=await Dbinsert().db.collection("users").doc(email).get();
        if (existdata.exists) {
          String phone = existdata.data()!['phone'];
          String name = existdata.data()!['username'];
          setsession(name, email, phone);
        }
        else {
          setsession("null", "null", "null");
        }

        loginstatus = true;
      }
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
    print(await SessionManager().containsKey("googlebtn"));
    final user=auth.currentUser;
    try {
      if(!await SessionManager().containsKey("googlebtn"))
        {
          await auth.createUserWithEmailAndPassword(email: email, password: password);

        }
       auth.currentUser?.updateDisplayName(username);
       await Dbinsert().addNewUser(username, email, password, firstname, lastname, username,phone);
       errorstatus=true;
      if(!auth.currentUser!.emailVerified){
        await auth.currentUser?.sendEmailVerification();
      }
      else if(auth.currentUser!.emailVerified && auth.currentUser!=null)
        {

          Navigator.pushNamed(context, Routes.pinsetup);
          String? s_name=auth.currentUser!.displayName;
          String? s_email=auth.currentUser!.email;
          setsession(s_name!, s_email!,phone);
        }
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
      await SessionManager().set("login", false);
      await SessionManager().update();
     // Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, Routes.pinscreen, (Route<dynamic> route) => false);

    } catch (e) {
      print("Error Signing Out $e");
    }
  }
   Future innitial(BuildContext context) async {
    if (auth.currentUser != null) {
      //print("Already Login ${user.email}");
     Navigator.pushNamed(context, Routes.dashboard);
    }

    notifyListeners();
  }
   Future checklogin(BuildContext context) async {
     final session=await SessionManager().containsKey("pin");
    if (!session) {
      //print("Already Login ${user.email}");
      logout(context);
    }
    notifyListeners();
  }
   setsession(String name, String email,String phone) async {
     await SessionManager().set("name", name);
     await SessionManager().set("email", email);
     await SessionManager().set("phone", phone);
    notifyListeners();
  }
   Future<List> getsession() async {
     if(await SessionManager().containsKey("name"))
       {
         session_email= await SessionManager().get("email");
         session_name= await SessionManager().get("name");
         session_phone= await SessionManager().get("phone");
       }

    notifyListeners();

    return[session_email,session_name,session_phone];

   }
   countries() async {
    country.clear();
    country.add("Send to ?");
    double aa=0;

    Dbinsert().db.collection("convert").get().then((value) {
      for(var i in value.docs)
      {
        Dbinsert().db.collection('convert').get().then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc)
          {
             aa+=doc['amount'];

           // country.add(namecount);

            //data.add({doc['Grams']});
          });
        });
      }

    });


    //country.add("Send to ?");
      // country.add("Ghana");
      // country.add("Nigeria");
      // country.add("Togo");
       notifyListeners();
       //print(country);
      return country;
  }
   Future<List> getTransactions() async {
    final List data=[];
    double totalgram=0;
    double totalamount=0;

    try {
      Dbinsert().db.collection("convert").get().then((value) {
        for(var i in value.docs)
        {
          Dbinsert().db.collection('convert').get().then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc)
            {
              totalgram+=doc['amount'];
              totalamount+=doc['amount'];
              //print(totalamount);
              //data.add({doc['Grams']});
            });
          });
        }

      });
    }
    catch(e){
      print(e);

    }

    data.add(totalgram);
    data.add(totalamount);
    print(totalgram);
    return data;
  }
   static Future<FilePickerResult?> pickfile() async{
     FilePickerResult? result;
      try
      {
        result= await FilePicker.platform.pickFiles(type: FileType.image, dialogTitle: "Payment Screenshot");

      }on FileSystemException catch(e)
     {
       print(e.message);

     }
     return result;


  }
   Future<String> momoname(String phone)async{
     String name="";
     try{
       var url = Uri.https('kologsoft.net', 'rainin/momoverify');
       var response = await http.post(url, body: {'phone':phone});
       name=response.body;

     }on http.ClientException catch(e){

       print(e.message);

     }
     notifyListeners();
     return name;

   }
   ngbankverify(String accnumber,String code,String tocountry)async{
      if(tocountry.toLowerCase()=="nigeria")
        {
          try{
            var url = Uri.https('kologsoft.net', 'rainin/nigeriabf');
            var response = await http.post(url, body: {'accnumber':accnumber,'code':code});
            var name =response.body.split("||");
            if(name[1]=="0")
            {
              matched=true;
              accountnotfoundtxt=name[0];
              accname="";

            }
            else
            {
              matched=false;
              accountnotfoundtxt="";
              accname=name[0];
              momotype="Bank Account";

            }
            //name.add(response.body);
          }on http.ClientException catch(e){

            print(e.message);

          }

        }
      else{
        try{
          var url = Uri.https('kologsoft.net', 'rainin/momoverify');
          var response = await http.post(url, body: {'phone':accnumber});
          print('Response status: ${response.statusCode}');
          print('Response body mommo: ${response.body}');
          var name=response.body.split("||");
          if(name[1]=="0")
          {
            matched=true;
            accountnotfoundtxt=name[0];
            accname="";

          }
          else
          {
            momotype=name[2];
            matched=false;
            accountnotfoundtxt="";
            accname=name[0];

          }
        }on http.ClientException catch(e){

          print(e.message);

        }

      }

     notifyListeners();

   }
   ngbanks()async{
     try{
       //https://kologsoft.net/rainin/nameverify"
       var url = Uri.https('kologsoft.net', 'rainin/ngbanks');
       var response = await http.post(url, body: {});
       //print('Response status: ${response.statusCode}');
       final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
       final Map<String, dynamic> datum=responseJson;
       String ddd=response.body.toString();
       final replaced=ddd.replaceAll("{", "");
       final freplaced=replaced.replaceAll("}", "");
       List datam=freplaced.split(",");
       banks.clear();
       bankscode.clear();
       for(int i=0; i<datam.length;i++){
         String bankdata=datam[i];
         List bks=bankdata.split(":");
         final ffreplaced=bks[1].replaceAll('"', "");
         final fffreplaced=bks[0].replaceAll('"', "");
         banks?.add(ffreplaced);
         bankscode!.add(fffreplaced);
        // print("ng ${bks[0]}-${bks[1]}");

       }

     }on http.ClientException catch(e){

       print(e.message);

     }
     notifyListeners();

   }
   Widget newdisplayfile(){
     if(file!=null) {
       // print(img64);

       return Image.file(file!,fit: BoxFit.contain,);
     }
     else
     {
       return const Icon(Icons.image,size: 50,);
     }

   }
   Widget displayfile(String url){
     Widget widget= Text("No Image Uploaded");

     if(imageUrl.isNotEmpty) {
       widget= Image.network(url,fit: BoxFit.contain,);
     }
     else
     {
       widget= const Text("NO Image Uploaded");
     }
     notifyListeners();
     return widget;

   }
   newupload()async{
     final timestamp=DateTime.timestamp().millisecondsSinceEpoch;
     final uid=auth.currentUser?.uid;
     try {
       final storageRef = FirebaseStorage.instance.ref();
       final imageRef = storageRef.child("$uid$timestamp.jpg");
       final ImagePicker picker = ImagePicker();
       // Create file metadata including the content type
       XFile? image = await picker.pickImage(source: ImageSource.gallery);
       if (image != null) {
         file = File(image.path);
         var metadata = SettableMetadata(contentType: "image/jpeg",);
         await imageRef.putFile(file!, metadata).then((TaskSnapshot taskSnapshot) {
           if (taskSnapshot.state == TaskState.success) {
             taskSnapshot.ref.getDownloadURL().then((imageURLs){
               imageUrl=imageURLs;
              print("Upload Completed");
             });
           }
           else if (taskSnapshot.state == TaskState.running) {
              print("Task Statte...${taskSnapshot.state}");
             // Show Prgress indicator
           }
           else if (taskSnapshot.state == TaskState.error) {
             errorMsgs=TaskState.error.name;
             print("Error MSG: ${TaskState.error}");
             // Handle Error Here
           }
         });

       } else {
         errorMsgs="No file selected";

       }
     } on FirebaseException catch (e) {
       errorMsgs=e.message!;
       print("MSG: $e");
     }
     notifyListeners();
     print("ERRROr $errorMsgs");
   }
   changeimage(String key)async{
     print("key: $key");
     final timestamp=DateTime.timestamp().millisecondsSinceEpoch;
     final uid=auth.currentUser?.uid;
     try {
       final storageRef = FirebaseStorage.instance.ref();
       final imageRef = storageRef.child("$uid$timestamp.jpg");
       final ImagePicker picker = ImagePicker();
       // Create file metadata including the content type
       XFile? image = await picker.pickImage(source: ImageSource.gallery);
       if (image != null) {
         file = File(image.path);
         var metadata = SettableMetadata(contentType: "image/jpeg",);
         await imageRef.putFile(file!, metadata).then((TaskSnapshot taskSnapshot) {
           if (taskSnapshot.state == TaskState.success) {
             taskSnapshot.ref.getDownloadURL().then((imageURLs) async {
              print("Upload Completed");
              await Dbinsert().db.collection("sendmoney").doc(key).set({Dbfield.image:imageURLs},SetOptions(merge: true));

              imageUrl=imageURLs;
              notifyListeners();


             });
           }
           else if (taskSnapshot.state == TaskState.running) {
              print("Task Statte...${taskSnapshot.state}");
             // Show Prgress indicator
           }
           else if (taskSnapshot.state == TaskState.error) {
             errorMsgs=TaskState.error.name;
             print("Error MSG: ${TaskState.error}");
             // Handle Error Here
           }
         });

       } else {
         errorMsgs="No file selected";

       }
     } on FirebaseException catch (e) {
       errorMsgs=e.message!;
       print("MSG: $e");
     }
     notifyListeners();
   }
   void getConnectionType() async{
     // bool cnt=false;
     //  InternetConnectionChecker().onStatusChange.listen(
     //       (InternetConnectionStatus status) {
     //     switch (status) {
     //       case InternetConnectionStatus.connected:
     //         cnt=true;
     //       // ignore: avoid_print
     //         print('Data connection is available.');
     //         break;
     //       case InternetConnectionStatus.disconnected:
     //         cnt=false;
     //       // ignore: avoid_print
     //         print('You are disconnected from the internet.');
     //         break;
     //     }
     //   },
     // );
    // print(cnt);
     notifyListeners();
   }
}

