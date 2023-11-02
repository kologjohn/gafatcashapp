import 'package:flutter/material.dart';
import 'package:gafatcash/startup/controller/accounts.dart';
import 'package:gafatcash/startup/controller/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'global.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyBSSr_ZtiG9eys6tCpVqJdTPjClejzrZ-g", appId: "1:542035889260:android:7f072e027fec60b4eedc49", messagingSenderId: "", projectId: "gafatcash-405b7"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirebaseAccounts>(
      create: (BuildContext context)=>FirebaseAccounts(),
      child: MaterialApp(
        routes: pages,
        initialRoute: Routes.login,
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
