import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gafatcash/global.dart';
import 'package:gafatcash/startup/components/forgot_password.dart';
import 'package:provider/provider.dart';
import '../widgets/social_button.dart';
import '../controller/accounts.dart';
import 'forgot_screen.dart';
import 'login_field.dart';
import '../controller/routes.dart';
class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginformkey=GlobalKey<FormState>();
  bool validate(){
    return loginformkey.currentState!.validate();
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
                          key: loginformkey,
                          child: Column(
                            children: [
                              Image.asset('assets/images/signin_balls.png'),
                              const Text('Sign In.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                ),
                              ),
                              const SizedBox(height: 50,),
                              LoginField(hintText: 'Email',controller: email,validationBuilder: ValidationBuilder().email(),textInputType: TextInputType.emailAddress,),
                              const SizedBox(height: 15,),
                              LoginField(hintText: 'Password',controller:password ,validationBuilder: ValidationBuilder().minLength(6),textInputType: TextInputType.visiblePassword,),
                              const SizedBox(height: 15,),
                              const ForgotPasText(),
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
                                    if(validate()){
                                      final progress=ProgressHUD.of(context);
                                      progress!.show();
                                      String finalemail=email.text.trim();
                                      String finalpassword=password.text.trim();
                                      String mylogin= await value.login(finalemail, finalpassword, context);
                                      print(value.error);

                                      if(!mylogin.isEmpty){
                                        SnackBar snackbar=  SnackBar(
                                            backgroundColor: Colors.red,
                                            showCloseIcon: true,
                                            closeIconColor: Colors.white,
                                            content: Text("Error!! $mylogin",
                                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                        progress.dismiss();
                                      }
                                      else
                                      {
                                        Navigator.pushNamed(context, Routes.dashboard);
                                        SnackBar snackbar= const SnackBar(backgroundColor:Colors.green,content: Text("Login Successful",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),));
                                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                        progress.dismiss();

                                      }
                                      print(finalemail);
                                      Future.delayed(Duration(seconds: 10),(){
                                        progress.dismiss();
                                      });
                                    }

                                    // progress!.show();
                                    // print(validate());
                                    //  await FirebaseAccounts().signup(email.text, password.text);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(395, 55),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    //'Sign in',
                                    'Sign in',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),

                              // ElevatedButton(
                              //   onPressed: () async {
                              //    await FirebaseAccounts().signup(email.text, password.text);
                              //   },
                              //   style: ElevatedButton.styleFrom(
                              //     fixedSize: const Size(395, 55),
                              //     backgroundColor: Colors.transparent,
                              //     shadowColor: Colors.transparent,
                              //   ),
                              //   child: const Text(
                              //     'Sign In',
                              //     style: TextStyle(
                              //       fontWeight: FontWeight.w600,
                              //       fontSize: 17,
                              //     ),
                              //   ),
                              // ),
                              //const SizedBox(height: 20,),
                              const SizedBox(height: 15,),
                              const Text(
                                '- Or continue with -',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(height: 15),
                              // const SocialLogin(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SocialButton(
                                    iconPath: 'assets/svgs/g_logo.svg',
                                    label: '',horizontalPadding: 20, onPressed: () async {
                                      final pro=ProgressHUD.of(context);
                                     // pro!.show();
                                      //await value.auth.signOut();
                                      String kk=await value.googlesignup(context);
                                      SnackBar snack=SnackBar(content: Text(kk));
                                      ScaffoldMessenger.of(context).showSnackBar(snack);
                                  },
                                  ),
                                  const SizedBox(width: 10,),
                                  SocialButton(
                                    iconPath: 'assets/svgs/f_logo.svg',
                                    label: '', horizontalPadding: 20, onPressed: () {  },
                                  ),
                                ],
                              ),


                              const SizedBox(height: 15,),
                              const ForgotPassBtn(),
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
