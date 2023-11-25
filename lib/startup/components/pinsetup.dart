import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gafatcash/global.dart';
import 'package:gafatcash/startup/controller/routes.dart';
import 'package:provider/provider.dart';
import '../controller/accounts.dart';

class Pinsetup extends StatefulWidget {

  const Pinsetup({super.key});

  @override
  State<Pinsetup> createState() => _PinscreenState();
}

class _PinscreenState extends State<Pinsetup> {
  bool forgotvisible=false;

  @override
  void initState() {
    // TODO: implement initState
    //FirebaseAccounts().innitial(context);
    super.initState();
  }
  final pingkey=GlobalKey<FormState>();
  TextEditingController pin=TextEditingController();
  TextEditingController cpin=TextEditingController();
  bool validate(){
    return pingkey.currentState!.validate();
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
                          key: pingkey,
                          child: Column(
                            children: [
                              Image.asset('assets/images/signin_balls.png'),
                              const Text('PIN SETUP.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 50,),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 400,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    validator: ValidationBuilder().minLength(4).maxLength(4).build(),
                                    style: const TextStyle(fontSize: 20,),
                                    controller: pin,
                                    keyboardType: const TextInputType.numberWithOptions(),
                                    decoration: const InputDecoration(
                                      label: Text("Enter Your PIN"),
                                      hintText: "Enter Your Pin",
                                    ),
                                  ),
                                ),
                              ),

                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 400,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    validator: ValidationBuilder().minLength(4).maxLength(4).build(),
                                    style: const TextStyle(fontSize: 20,),
                                    controller: cpin,
                                    keyboardType: const TextInputType.numberWithOptions(),
                                    decoration: const InputDecoration(
                                      label: Text("Confirm Your PIN"),
                                      hintText: "Enter Your Pin",
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
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
                                    if(validate()){
                                      String pin_one=pin.text.trim();
                                      String pin_two=cpin.text.trim();
                                      if(pin_one==pin_two && pin_one.length==4 && pin_two.length==4)
                                        {
                                          if(await SessionManager().containsKey("pin"))
                                            {
                                              print(await SessionManager().get("login"));
                                              SnackBar snackbar= const SnackBar(backgroundColor:Colors.deepOrangeAccent,content: Text("Pin Setup already",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),));
                                              ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                              Navigator.pushNamed(context, Routes.pinscreen);

                                            }
                                            else{
                                            await SessionManager().set("pin", pin_one);
                                            await SessionManager().set("login", true);
                                            SnackBar snackbar= const SnackBar(backgroundColor:Colors.green,content: Text("Pin Setup Successfully",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),));
                                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                            Navigator.pushNamed(context, Routes.pinscreen);

                                          }
                                            }
                                      else
                                        {
                                          SnackBar snackbar= const SnackBar(backgroundColor:Colors.red,content: Text("Pin must match and length equal to four(4) digits",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),));
                                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
                                    'Save PIN',
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