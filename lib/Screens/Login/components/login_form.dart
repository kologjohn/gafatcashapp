import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:gafatcash/controllers/accounts_controllers.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';
class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  bool validate(){
   return _form.currentState!.validate();
  }
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      barrierColor: Colors.black45,
      child: Form(
        key: _form,
        child: Consumer<FirebaseAccounts>(
          builder: (BuildContext context, value, Widget? child) {
            return  Column(
              children: [

                TextFormField(
                  controller: email,
                  validator: ValidationBuilder().minLength(5).build(),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (email) {},
                  decoration: const InputDecoration(
                    hintText: "Email Address",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: password,
                    validator: ValidationBuilder().minLength(6).build(),
                    textInputAction: TextInputAction.send,
                    obscureText: true,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Your password",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                ElevatedButton(
                  onPressed: () async {
                    if(validate())
                    {

                      final progres=ProgressHUD.of(context);
                      progres!.showWithText("Signing...");
                      progres?.show();

                      //print(value.error);
                      // Future.delayed(Duration(seconds: 3),(){
                      //   progres!.dismiss();
                      // });
                      String final_email=email.text.trim();
                      String final_password=password.text.trim();
                      await value.login(final_email, final_password);
                      SnackBar snack=SnackBar(content: Text("${value.error}"));
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    //  print(value.error);

                    }


                  }, child: Text("Login"),
                ),

                const SizedBox(height: defaultPadding),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          },
          //child:,
        ),
      ),
    );
  }
}
