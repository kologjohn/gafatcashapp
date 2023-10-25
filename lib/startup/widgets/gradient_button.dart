import 'package:flutter/material.dart';
import 'package:gafatcash/global.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
        onPressed: () {

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
    );
  }
}
