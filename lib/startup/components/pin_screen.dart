import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gafatcash/global.dart';
import 'package:gafatcash/startup/components/forgot_password.dart';
import 'package:provider/provider.dart';
import '../widgets/social_button.dart';
import '../controller/accounts.dart';
import 'forgot_screen.dart';
import 'login_field.dart';
import '../controller/routes.dart';
class Pinscreen extends StatefulWidget {

  const Pinscreen({super.key});

  @override
  State<Pinscreen> createState() => _PinscreenState();
}

class _PinscreenState extends State<Pinscreen> {
  bool forgotvisible=false;
  bool obscure=true;

  @override
  void initState() {
    // TODO: implement initState
    //FirebaseAccounts().innitial(context);
    super.initState();
  }
  final pinvalidate=GlobalKey<FormState>();
  TextEditingController pin=TextEditingController();
  bool validate(){
    return pinvalidate.currentState!.validate();
  }
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Consumer<FirebaseAccounts>(
      builder: (BuildContext context,  value, child) {
        return  ProgressHUD(
          barrierColor: Colors.transparent,
          child: Builder(
              builder: (context) {
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: pinvalidate,
                          child: Column(
                            children: [
                              Image.asset('assets/images/signin_balls.png'),
                              const Text('ENTER PIN.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 70,),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 400,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    obscureText: obscure,
                                    validator: ValidationBuilder().minLength(4).maxLength(4).build(),
                                    style: const TextStyle(fontSize: 30,),
                                    controller: pin,
                                    keyboardType: const TextInputType.numberWithOptions(),
                                    decoration:  InputDecoration(
                                      suffixIcon: GestureDetector(onTap:(){
                                        setState(() {
                                          if(obscure)
                                            {
                                              obscure=false;

                                            }
                                          else
                                            {
                                              obscure=true;

                                            }
                                        });

                                      },child: Icon(Icons.remove_red_eye)),
                                      hintText: "Enter Your Pin",
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Visibility(
                                    visible: forgotvisible,
                                    child: GestureDetector(
                                      onTap: (){
                                       // Navigator.pushNamed(context, Routes.dashboard);
                                      },
                                      child: GestureDetector(
                                        onTap: () async{
                                          await FirebaseAccounts().auth.signOut();
                                          await SessionManager().destroy();
                                          Navigator.pushNamed(context,Routes.login);

                                          SnackBar snackbar= const SnackBar(backgroundColor:Colors.green,content: Text("Sign in to again to setup a new pin",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),));
                                          ScaffoldMessenger.of(context).showSnackBar(snackbar);

                                        },
                                        child: const Text(
                                          'Forgot PIN?',
                                          style: TextStyle(
                                            color: Global.gradient3,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Container(
                                decoration: BoxDecoration(
                                    gradient:  const LinearGradient(
                                      colors: [
                                        Global.gradient1,
                                        Global.gradient2,
                                        Global.gradient3,
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                    ),
                                    borderRadius: BorderRadius.circular(7)
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (validate()) {
                                      int mypin = int.parse(pin.text.trim());
                                      if (await SessionManager().containsKey(
                                          "pin")) {
                                        int session_pin = await SessionManager()
                                            .get("pin");
                                        print(await session_pin);
                                        if (session_pin == mypin) {
                                          Navigator.pushNamed(
                                              context, Routes.dashboard);
                                        }
                                        else {
                                          setState(() {
                                            forgotvisible = true;
                                          });

                                          SnackBar snackbar = const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text("Incorrect Pin",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight
                                                        .bold),));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                                        }
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(395, 55),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    //'Sign in',
                                    'Login',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),
        );

      },
      // child:,
    );
  }
}
void file(){

}