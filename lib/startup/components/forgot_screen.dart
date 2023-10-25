import 'package:flutter/material.dart';

import '../../global.dart';
import '../controller/routes.dart';

class ForgotPassBtn extends StatelessWidget {
  const ForgotPassBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Don\'t have an account?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
          ),
          InkWell(
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, Routes.signup);
              },
              child: const Text(
                ' Sign Up',
                style: TextStyle(
                  color: Global.gradient3,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
