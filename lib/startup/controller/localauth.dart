import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
final _auth = LocalAuthentication();
Future<bool> hasBiometrics() async {
  final isAvailable = await _auth.canCheckBiometrics;
  final isDeviceSupported = await _auth.isDeviceSupported();
  return isAvailable && isDeviceSupported;
}

Future<bool> authenticate() async {
  final isAuthAvailable = await hasBiometrics();
  if (!isAuthAvailable) return false;
  try {
    return await _auth.authenticate(
        localizedReason: 'Touch your finger on the sensor to login');
  } catch (e) {
    return false;
  }
}


// ···
Future<bool>verify() async{
  bool didAuthenticate=false;
  try{
     await _auth.authenticate(

        localizedReason: 'Please authenticate to show your dashboard',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: '!',
            cancelButton: 'No thanks',
          ),
          IOSAuthMessages(
            cancelButton: 'No thanks',
          ),
        ]);
     didAuthenticate=true;
  }on PlatformException catch(e){
    print("login Error:${e.message}");

  }

  return didAuthenticate;

}
