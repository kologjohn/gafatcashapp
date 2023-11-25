import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:gafatcash/startup/controller/accounts.dart';
import 'package:gafatcash/startup/controller/routes.dart';
import 'package:provider/provider.dart';

import '../../global.dart';
import 'login_field.dart';
import 'package:form_validator/form_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
   //FormState<FormState> signupkey=GlobalKey<FormState>();
   final signupkey = GlobalKey<FormState>();
   bool passwordfield=true;
   bool validate(){
     return signupkey.currentState!.validate();
   }
   TextEditingController email=TextEditingController();
   TextEditingController password=TextEditingController();
   TextEditingController  contact=TextEditingController();
   TextEditingController firstname=TextEditingController();
   TextEditingController lastname=TextEditingController();
   TextEditingController username=TextEditingController();
   
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      barrierColor: Colors.white10,
      child: ProgressHUD(
        barrierColor: Colors.black38,
        child: Builder(
          builder: (context) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<FirebaseAccounts>(
                        builder: (BuildContext context, value,child) {
                          print(value.auth.currentUser);
                          final user=value.auth.currentUser;
                       //   value.getsession();
                          if(user!=null)
                          {
                            if(user!.displayName!=null) {
                              String? displayname = value.auth.currentUser!.displayName;
                              String? loginmail = value.auth.currentUser!.email;
                              List? namelist = displayname!.split(" ");
                              String fname = namelist[0];
                              String lname = namelist[1];
                              firstname.text = fname;
                              lastname.text = lname;
                              username.text = displayname;
                              email.text = loginmail!;
                              passwordfield = false;
                            }
                            //emailTxt.text=loginemail;
                          }
                          return Form(
                            key: signupkey,
                            child: Column(
                              children: [
                                Image.asset('assets/images/signin_balls.png'),
                                const Text('Sign Up.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                LoginField(hintText: 'First Name',controller: firstname,validationBuilder: ValidationBuilder().minLength(2),textInputType: TextInputType.name,),
                                const SizedBox(height: 15,),
                                LoginField(hintText: 'Last Name',controller: lastname,validationBuilder: ValidationBuilder().minLength(2),textInputType: TextInputType.name,),
                                const SizedBox(height: 15,),
                                LoginField(hintText: 'User Name',controller: username,validationBuilder: ValidationBuilder().minLength(2),textInputType: TextInputType.name,),
                                const SizedBox(height: 15,),
                                LoginField(hintText: 'Email',controller: email,validationBuilder: ValidationBuilder().email(),textInputType: TextInputType.emailAddress,),
                                const SizedBox(height: 15,),
                                LoginField(hintText: 'Phone',controller: contact,validationBuilder: ValidationBuilder().minLength(10),textInputType: TextInputType.phone,),
                                const SizedBox(height: 15,),
                                Visibility(visible:passwordfield,child: LoginField(hintText: 'Password',controller: password,validationBuilder: ValidationBuilder().minLength(6),textInputType: TextInputType.visiblePassword,)),
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
                                      if(validate())
                                      {
                                        String femail=email.text.trim();
                                        String fpassword=password.text.trim();
                                        String fusername=username.text.trim();
                                        String ffirstname=firstname.text.trim();
                                        String flastname=lastname.text.trim();
                                        String fcontact=contact.text.trim();
                                        final progress=ProgressHUD.of(context);
                                        progress!.show();
                                        final myaccout= await FirebaseAccounts().signup(context,femail, fpassword, ffirstname, flastname, fusername, fcontact);
                                        if(myaccout.isEmpty)
                                        {
                                          Navigator.pushNamed(context, Routes.pinsetup);
                                          SnackBar snackbar= const SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text("Account Created Successfully.Setup your pin",
                                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                          progress.dismiss();
                                        }
                                        else
                                        {
                                          SnackBar snackbar=  SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text("Error!! $myaccout",
                                                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                          progress.dismiss();
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
                                      'Create Account',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                )  ,                  //const SizedBox(height: 20,),
                                const SizedBox(height: 15,),
                                // const Text(
                                //   'Or',
                                //   style: TextStyle(
                                //     fontSize: 17,
                                //   ),
                                // ),
                                // const SizedBox(height: 15),
                                // // const SocialLogin(),
                                // SocialButton(
                                //   iconPath: 'assets/svgs/g_logo.svg',
                                //   label: 'Continue with Google',horizontalPadding: 100, onPressed: () {  },
                                // ),
                                // const SizedBox(height: 10,),
                                // SocialButton(
                                //   iconPath: 'assets/svgs/f_logo.svg',
                                //   label: 'Continue with Facebook', horizontalPadding: 90, onPressed: () {  },
                                // ),
                                //
                                // const SizedBox(height: 15,),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
