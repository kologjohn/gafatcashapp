import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class LoginModel{
  String staffid="";
  String password="";
  String login="";
  LoginModel(this.staffid,this.password,this.login);

  //
  // void loginrespons(String staffid,String password.String login) async{
  //   var url = Uri.https('kologsoftpos.com', 'class/forms');
  //   var response = await http.post(url, body: {'staffid': pa, 'password': '123456','login':'1'});
  // }

// var url = Uri.https('kologsoftpos.com', 'class/forms');
// var response = await http.post(url, body: {'staffid': 'KS014', 'password': '123456','login':'1'});


}