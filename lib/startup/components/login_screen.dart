import 'package:flutter/material.dart';
import 'package:gafatcash/global.dart';
import 'package:gafatcash/startup/components/forgot_password.dart';
import '../widgets/social_button.dart';
import '../controller/accounts.dart';
import 'forgot_screen.dart';
import 'login_field.dart';


class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   TextEditingController email=TextEditingController();
   TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                 LoginField(hintText: 'Email',controller: email,),
                const SizedBox(height: 15,),
                 LoginField(hintText: 'Password',controller:password ,),
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
                    await FirebaseAccounts().signup(email.text, password.text);
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
                      label: '',horizontalPadding: 20, onPressed: () {  },
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
    );
  }
}
