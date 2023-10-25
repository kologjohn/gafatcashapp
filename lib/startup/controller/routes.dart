import '../components/signup_screen.dart';
import '../components/login_screen.dart';
class Routes{
 static String login="login";
  static String signup="signup";
}

final pages={
  Routes.login:(context)=>LoginScreen(),
  Routes.signup:(context)=>SignUpScreen()
};