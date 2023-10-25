import 'package:flutter/material.dart';
import '../../controllers/accounts_controllers.dart';
import '../widgets/social_button.dart';
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
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async {
                   //await FirebaseAccounts().signup(email.text, password.text);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(395, 55),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    //'Sign in',
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
                 //const SizedBox(height: 20,),
                const SizedBox(height: 15,),
                const Text(
                  'Or',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                 const SizedBox(height: 15),
                // const SocialLogin(),
                 SocialButton(
                  iconPath: 'assets/svgs/g_logo.svg',
                  label: 'Continue with Google',horizontalPadding: 100, onPressed: () {  },
                ),
                const SizedBox(height: 10,),
                 SocialButton(
                  iconPath: 'assets/svgs/f_logo.svg',
                  label: 'Continue with Facebook', horizontalPadding: 90, onPressed: () {  },
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
