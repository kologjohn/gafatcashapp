import 'package:gafatcash/dashboard/components/chart.dart';
import 'package:gafatcash/startup/components/pin_screen.dart';
import 'package:gafatcash/startup/components/pinsetup.dart';

import '../../dashboard/components/chat_page.dart';
import '../components/signup_screen.dart';
import '../components/login_screen.dart';
import '../../dashboard/components/dashboard.dart';

class Routes{
 static String login="login";
  static String signup="signup";
  static String dashboard="dashboard";
  static String charts="charts";
  static String pinscreen="pinscreen";
  static String pinsetup="pinsetup";
}

final pages={
  Routes.login:(context)=>const LoginScreen(),
  Routes.signup:(context)=>const SignUpScreen(),
  Routes.dashboard:(context)=>const Dashboard(),
  Routes.charts:(context)=>const ChatPage(),
  Routes.pinscreen:(context)=>const Pinscreen(),
  Routes.pinsetup:(context)=>const Pinsetup(),
};