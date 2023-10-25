import 'package:flutter/material.dart';

import '../widgets/gradient_button.dart';
import 'login_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController email,password,contact,firstname,lastname,username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset('assets/images/signin_balls.png'),
                  const Text('Sign Up.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 50,),
                   LoginField(hintText: 'First Name',controller: firstname),
                  const SizedBox(height: 15,),
                   LoginField(hintText: 'Last Name',controller: lastname,),
                  const SizedBox(height: 15,),
                   LoginField(hintText: 'User Name',controller: username,),
                  const SizedBox(height: 15,),
                   LoginField(hintText: 'Email',controller: email,),
                  const SizedBox(height: 15,),
                   LoginField(hintText: 'Phone',controller: contact,),
                  const SizedBox(height: 15,),
                   LoginField(hintText: 'Password',controller: password,),
                  const SizedBox(height: 20,),
                  const GradientButton(),
                  //const SizedBox(height: 20,),
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
            ),
          ),
        ),
      ),
    );
  }
}
