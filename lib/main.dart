import 'package:flutter/material.dart';
import 'package:gafatcash/startup/controller/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'global.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyBypUEdN1PXwEc35IdIt-cv8dnRIz1RAx0", appId: "1:1058517351380:android:3baaa3866ef90632793441", messagingSenderId: "", projectId: "gafatcashapp-6c45f"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: pages,
      initialRoute: Routes.login,
      debugShowCheckedModeBanner: false,
      title: 'Responsive Form',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Global.backgroundColor,
      ),
      //home: const LoginScreen(),
    );
  }
}
