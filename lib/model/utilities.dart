import 'package:flutter/material.dart';
class Utilities{

  bool validate(GlobalKey<FormState> _form) {
    _form.currentState!.validate();
    return  _form.currentState!.validate();
  }

  Widget progress(String wait){
    if(wait=="Login")
    {
      wait="login";
      return const Text("Login");
    }
    else if(wait=="Sign Up")
      {
        wait="Sign Up";
        return const Text("SIGN UP");
      }
    else
    {
      return const CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 6,);
    }

  }
}
