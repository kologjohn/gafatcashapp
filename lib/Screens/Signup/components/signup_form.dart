import 'dart:io';
import 'package:flutter/material.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import 'package:form_validator/form_validator.dart';
import '../../../model/forms.dart';
import '../../../model/utilities.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key,}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  Formsmodel formsmodel=Formsmodel();
  Utilities utilities=Utilities();
  String denied="";
  String wait="Sign Up";
  void emptyerror(){
    setState(() {denied="";});
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(denied,style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16.0
            ),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              onChanged: (name){
                formsmodel.company=name;
                emptyerror();
              },
              validator: ValidationBuilder().minLength(2).maxLength(32).build(),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved:(email){},
              decoration: const InputDecoration(
                hintText: "Company Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.home,),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
            onChanged: (text){
              formsmodel.email=text;
              emptyerror();


            },
              validator: ValidationBuilder().email().maxLength(32).build(),
              keyboardType: TextInputType.emailAddress,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Company/Personal Email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              onChanged: (text){
                formsmodel.phone=text;
                emptyerror();

              },
              validator: ValidationBuilder().maxLength(10).minLength(10).phone().build(),
              keyboardType: TextInputType.phone,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Phone Number",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
            ),
          ),

          TextFormField(
            onChanged: (text){
              formsmodel.abrreviated=text;
              emptyerror();

            },
            validator: ValidationBuilder().minLength(2).maxLength(11).build(),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Company Abbreviated Name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.sms),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              onChanged: (text){
                formsmodel.password=text;
                emptyerror();

              },
              validator: ValidationBuilder().minLength(6).build(),
              textInputAction: TextInputAction.done,
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
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async{
              bool allval=utilities.validate(_form);
              if(!allval)
                {
                  //print("object");
                  return null;
                }

              setState(() {wait="Waiting";});
            var url=Uri.https("kologsoftpos.com","class/forms");
            var response = await http.post(url, body: {
              'name': formsmodel.company,
              'email': formsmodel.email,
              'contact': formsmodel.phone,
              'senderid': formsmodel.abrreviated,
              'passwordone': formsmodel.password,
              'passwordtwo': formsmodel.password,
              'company':'1'
            }
            );
            print(response.body);
            if(response.body=="1000")
            {
              Navigator.push(context, MaterialPageRoute(builder: (context){return LoginScreen();}));
              setState(() {
                wait="Sign Up";
                denied="";
              });
            }
            else if(response.body=="2000")
              {
                setState(() {
                  denied="Account Already Exist";
                  wait="Sign Up";
                  //Duration dd=Duration(seconds: 15);
                  //sleep(dd);
                 // denied="";
                });
                Duration duration=Duration(seconds: 3);
                sleep(duration);

                // Navigator.push(context, MaterialPageRoute(builder: (context){
                //   return LoginScreen();
                // }));

              }
            else{
              setState(() {
                denied="Error Setting Up( ${response.body})";
                wait="Sign Up";
                Duration dd=Duration(seconds: 15);
                sleep(dd);
                denied="";
              });
              Duration duration=Duration(seconds: 3);
              sleep(duration);


            }

            },
            child: utilities.progress(wait),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}