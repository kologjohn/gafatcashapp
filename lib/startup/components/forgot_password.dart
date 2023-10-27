import 'package:flutter/material.dart';
import 'package:gafatcash/global.dart';
import 'package:gafatcash/startup/controller/routes.dart';

class ForgotPasText extends StatelessWidget {
  const ForgotPasText({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, Routes.dashboard);
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Global.gradient3,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
