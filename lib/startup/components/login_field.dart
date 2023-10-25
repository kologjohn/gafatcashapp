import 'package:flutter/material.dart';
import 'package:gafatcash/global.dart';
class LoginField extends StatelessWidget {
  final String hintText;
  final  TextEditingController controller;
  const LoginField({super.key, required this.hintText,required this.controller});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.all(27),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Global.borderColor,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Global.gradient2,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10)
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
