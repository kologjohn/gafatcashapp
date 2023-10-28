import '../components/signup_screen.dart';
import '../components/login_screen.dart';
import '../../dashboard/components/dashboard.dart';

class Routes{
 static String login="login";
  static String signup="signup";
  static String dashboard="dashboard";
}

final pages={
  Routes.login:(context)=>const LoginScreen(),
  Routes.signup:(context)=>const SignUpScreen(),
  Routes.dashboard:(context)=>const Dashboard(),
};