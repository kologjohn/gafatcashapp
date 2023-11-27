import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:gafatcash/startup/controller/accounts.dart';
import 'package:gafatcash/startup/controller/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'global.dart';
String tid="";
String mainpage=Routes.login;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb)
  {
    await Firebase.initializeApp(options:  const FirebaseOptions(apiKey: "AIzaSyD3qFTM2ruRBEEoNC2umyPSucKNMzyeZaQ", appId: "1:542035889260:android:7f072e027fec60b4eedc49", messagingSenderId: "", projectId: "gafatcash-405b7",storageBucket: "gafatcash-405b7.appspot.com"));

  }
  else{
    await Firebase.initializeApp(
      name: 'Gafat Cash',
      options: DefaultFirebaseOptions.web,
    ).whenComplete(() {
    });

  }


  final session=await SessionManager().containsKey("pin");
  if(session){
    bool loginstatus=await SessionManager().get("login");
    if(loginstatus){
      mainpage=Routes.dashboard;
    }
    else
      {
        mainpage=Routes.pinscreen;

      }
    //mainpage="pinscreen";
  }

  runApp( MyApp(initroute: mainpage,));
}

class MyApp extends StatefulWidget {
  String initroute="";
   MyApp({super.key,required this.initroute});
  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // if(FirebaseAccounts().auth.currentUser!=null)
    //   {
    //     FirebaseAccounts().getsession();
    //     print("Main Screen");
    //     mainroutes="dashboard";
    //   }

    // TODO: implement initState
    super.initState();
  }
  @override

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirebaseAccounts>(
      create: (BuildContext context)=>FirebaseAccounts(),
      child: MaterialApp(
        routes: pages,
        initialRoute: widget.initroute,
        debugShowCheckedModeBanner: false,
        title: 'GAFAT CASH',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Global.backgroundColor,
        ),
        //home: const LoginScreen(),
      ),
    );
  }
}
