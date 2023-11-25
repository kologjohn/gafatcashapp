import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> confirmation(BuildContext context, {required  title, required  content, required  textOK, required  textCancel}) async {
  if (await confirm(
  context,
  title:  Text(title),
  content:  Text(content),
  textOK:  ElevatedButton(onPressed: null,child:Text(textOK),style: ElevatedButton.styleFrom(foregroundColor: Colors.blue),),
  textCancel: ElevatedButton(onPressed: null,child:Text(textCancel),style: ElevatedButton.styleFrom(backgroundColor: Colors.red),),
  )) {
  return true;
  }
  return false;
}