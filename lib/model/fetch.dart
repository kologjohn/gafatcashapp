import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';


import 'dart:io';

void main(){
  printtask();
}
task1(){
  String txt="task one 1";
  print("task 1");

}
 void printtask() async{
  // https://kologsoftpos.com/production/model/api
   var url = Uri.https('kologsoftpos.com', '/production/model/api');
   var response = await http.post(url, body: {'staffid': 'KS014', 'password': '123456','login':'1'});
   var res=jsonDecode(response.body);
   int len=(res as Map<String, dynamic>).length;
   //print('Data: $len');
   //print('Response status: ${res.length}');
   //print('Response body: ${response.body}');

   //print(await http.read(Uri.https('kologsoftpos.com', 'class/api')));
  // task1();
  // String task2data=await task2();
  // task3(task2data);
    //getdata();
}

Future task2() async{
  Duration duration=Duration(seconds: 3);
    String txt="";
  await Future.delayed(duration,(){
    txt="task two results";
     // print("task 2 completed");
  });
  return txt;

}

task3(String task2data){
  String txt="task three 3";
  print("Task Three completed with $task2data");

}


Future<void> getdata() async {
  final client = RetryClient(http.Client());
  try {
    Response response=await get("kologsoftpos.com/class/api" as Uri);
    print(response);
  } finally {
    client.close();
  }
}
