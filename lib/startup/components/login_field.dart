import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gafatcash/global.dart';
class LoginField extends StatefulWidget {
  final String hintText;
  final  TextEditingController controller;
  final ValidationBuilder validationBuilder;
  final TextInputType textInputType;
  const LoginField({super.key, required this.hintText,required this.controller,required this.validationBuilder,required this.textInputType});

  @override
  State<LoginField> createState() => _LoginFieldState();

}

class _LoginFieldState extends State<LoginField> {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        keyboardType: widget.textInputType,
        validator: widget.validationBuilder.build(),
        controller: widget.controller,
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
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
