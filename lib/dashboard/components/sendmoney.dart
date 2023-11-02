import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gafatcash/global.dart';
import 'package:gafatcash/startup/controller/accounts.dart';
import 'package:provider/provider.dart';
import '../../startup/components/login_field.dart';
import '../../startup/controller/database.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final Stream<QuerySnapshot> _usersStream = Dbinsert().db.collection('convert').snapshots();
  final Stream<QuerySnapshot> _bankstream = Dbinsert().db.collection('ngbanks').snapshots();

  final _moneyform1 = GlobalKey<FormState>();
  final _moneyform2 = GlobalKey<FormState>();
  bool ghannastatus=true;
  bool continuestatus=true;
  bool mactched=false;
  String dropdownValue2 = 'MOMO Type';
  String dropdownValue3 = 'Select bank';

  int step1 = 0;
  int step2 = 1;
  int step3 = 2;

  bool validate1() {
    return _moneyform1.currentState!.validate();
  }

  bool validate2() {
    return _moneyform2.currentState!.validate();
  }

  String tocountry = "";
  String fromcountry = "";
  String bank = "";
  String accountxt="";
  String accholdertxt="";

  TextEditingController payAmount = TextEditingController();
  TextEditingController getAmount = TextEditingController();
  TextEditingController countryCurrency = TextEditingController();
  TextEditingController phone = TextEditingController();

  TextEditingController bene_phone = TextEditingController();
  TextEditingController bene_cphone = TextEditingController();
  TextEditingController bene_name = TextEditingController();
  TextEditingController momotype = TextEditingController();
  TextEditingController reason = TextEditingController();

  double sendingamount = 0;
  double recievedamount = 0;
  String tocurrencysymbol = "";
  String senderphone = "";
  double scale = 0;
  String dropdownvalue = 'Send to ?';
  int currentStep = 0;
  String sender_currency = "";
  String recipient_currency = "";
  String agreement = "";

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      barrierColor: Global.gradient3,
      child: Consumer<FirebaseAccounts>(
        builder: (BuildContext context, FirebaseAccounts value, Widget? child) {
          return Container(
              color: Global.backgroundColor,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Stepper(
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepTapped: (step) => setState(() {
                    currentStep = step;
                  }),
                  controlsBuilder: (context,_) {
                    return Row(
                      children: <Widget>[
                        TextButton(
                          onPressed: (){
                              bool isLastStep = (currentStep == getSteps().length - 1);
                              if (isLastStep) {
                                //Do something with this information
                              } else {
                                setState(() {
                                  currentStep += 1;
                                });
                              }



                          },
                          child: Visibility(
                            visible: continuestatus,
                            child: ElevatedButton(onPressed: (){

                              if(currentStep==step1)
                                {

                                  if(validate1()){
                                    setState(() {
                                      currentStep=step2;
                                    });
                                  }

                                }
                              else if(currentStep==step2)
                                {
                                  bool stage2=validate2();
                                  if(bene_cphone.text!=bene_phone.text)
                                    {
                                      bene_phone.selection.start.sign;
                                      stage2=false;
                                    }
                                   // print(stage2);
                                 if(stage2){
                                   setState(() {currentStep=step3;mactched=false;});
                                 }
                                 else
                                   {
                                     setState(() {
                                       mactched=true;
                                     });
                                   }
                                }
                              if(currentStep==step3)
                                {

                                }

                            },style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),child: const Text("Continue"),),
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            //print(currentStep);

                            currentStep == 0
                                ? null
                                : setState(() {
                              currentStep -= 1;
                            });
                          },
                          child: ElevatedButton(onPressed: null,style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan), child: const Text("Previous")),
                        ),
                      ],
                    );
                  },

                  steps: getSteps(),
                ),
              ));
        },
        // child: ,
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        subtitle: const Text("Summary"),
        state: currentStep > step1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= step1,
        title: const Text("Money"),
        content: Form(
          key: _moneyform1,
          child: Column(
            children: [
              Consumer<FirebaseAccounts>(
                builder: (BuildContext context, FirebaseAccounts value,
                    Widget? child) {
                  return StreamBuilder<QuerySnapshot>(
                      stream: _usersStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        List<double> tovalue = [];
                        List<String> countries = [];
                        List<String> scurrencies = [];
                        List<String> rcurrencies = [];
                        List<String> fromc = [];
                        // List of items in our dropdown menu
                        var items = ["Send to ?"];
                        if (snapshot.hasData) {
                          for (int i = 0; i < snapshot.data!.size; i++) {
                            String name = snapshot.data!.docs[i]['to'];
                            tovalue.add(snapshot.data!.docs[i]['amount']);
                            scurrencies
                                .add(snapshot.data!.docs[i]['sendercurrency']);
                            rcurrencies.add(
                                snapshot.data!.docs[i]['recipientcurrency']);
                            fromc.add(snapshot.data!.docs[i]['from']);
                            countries.add(name);
                            items.add(name);
                          }
                        } else {}

                        return ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                shape: BoxShape.rectangle),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                //contentPadding: EdgeInsets.all(27),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Global.borderColor,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Global.gradient2,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              hint: const Text("Select Country"),
                              isExpanded: true,
                              elevation: 2,
                              // Initial Value
                              value: dropdownvalue,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    //  value.getTransactions();
                                    //value.countries();
                                  },
                                  value: items,
                                  child: Text(items),
                               );
                              }).toList(),
                              onChanged: (text) {
                                getAmount.clear();
                                 payAmount.clear();
                                for (int i = 0; i < tovalue.length; i++) {
                                  if (text == countries[i]) {
                                    tocountry = text!;
                                    fromcountry = fromc[i];
                                    sender_currency = scurrencies[i];
                                    recipient_currency = rcurrencies[i];
                                    agreement = "You are confirming that we will  send the above amount in ${scurrencies[i]} to the recipient";
                                    scale = tovalue[i];
                                    if(tocountry.toLowerCase()=="nigeria"){
                                      setState(() {
                                        accholdertxt="Name of Beneficiary";
                                        accountxt="Account Number";
                                        ghannastatus=false;
                                      });
                                    }
                                    else
                                      {
                                        setState(() {
                                          ghannastatus=true;
                                          accountxt="MTN Mobile Money Number";
                                          accholdertxt="MTN Mobile Money Name";
                                        });

                                      }
                                  }
                                }
                                //print( await value.countries());
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      });
                },
                //child: ,
              ),
              const SizedBox(
                height: 10,
              ),
              //amount you pay
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: TextFormField(
                  controller: payAmount,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: ValidationBuilder().minLength(1).build(),
                  onChanged: (amount) {
                    setState(() {
                      if (amount.isEmpty) {
                        recievedamount = 0;
                        getAmount.text = "0";
                        return;
                      }
                      double fsm = double.parse(amount);
                      sendingamount = fsm;
                      recievedamount =Convert.truncateToDecimalPlaces((sendingamount * scale), 1);
                      getAmount.text = "$recievedamount";
                    });
                  },
                  // controller: controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text("Amount you pay in $sender_currency"),
                    //contentPadding: EdgeInsets.all(27),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Global.borderColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Global.gradient2,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Amount you pay in $sender_currency",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Amount Recipient get
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: TextFormField(
                  readOnly: true,
                  controller: getAmount,
                  keyboardType: TextInputType.number,
                  validator: ValidationBuilder().minLength(1).build(),
                  onChanged: (amount) {
                    setState(() {
                      recievedamount;
                    });
                  },
                  // controller: controller,
                  decoration: InputDecoration(
                    label: Text("Recipient Amount $recipient_currency"),
                    border: const OutlineInputBorder(),
                    //contentPadding: EdgeInsets.all(27),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Global.borderColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Global.gradient2,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Recipient Amount  $recipient_currency",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Your currency
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.number,
                  validator: ValidationBuilder().minLength(1).build(),
                  onChanged: (amount) {
                    double fsm = double.parse(amount);
                    sendingamount = fsm;
                  },
                  // controller: controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text("Sender Phone Number"),
                    //contentPadding: EdgeInsets.all(27),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Global.borderColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Global.gradient2,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Sender Phone Number",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Text(
                agreement,
                style: const TextStyle(color: Colors.amber),
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > step2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= step2,
        title: const Text("Beneficiary"),
        subtitle: const Text("Information"),
        content: Form(
          key: _moneyform2,
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: _bankstream,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
                    final bankcodelist =[];
                    var banknames = ['Select bank'];
                    if (snapshot1.hasData) {
                      //print("has data");
                     // print(snapshot.data!.size);
                      for (int i = 0; i < snapshot1.data!.size; i++) {
                        String name = snapshot1.data!.docs[i]['name'];
                        String code = snapshot1.data!.docs[i]['code'];
                        banknames.add(name);
                        bankcodelist.add(code);
                      }
                      if(tocountry.toLowerCase()=="nigeria")
                        {
                         return ConstrainedBox(
                            constraints: const BoxConstraints(

                              maxWidth: 400,
                            ),
                            child: DropdownButtonFormField(
                              onChanged: (selectedbank) {
                                bank=selectedbank!;

                                setState(() {
                                  dropdownValue2 = selectedbank!;

                                });
                              },
                              // controller: controller,
                              decoration: InputDecoration(
                                label: const Text("Select Bank"),
                                border: const OutlineInputBorder(),
                                //contentPadding: EdgeInsets.all(27),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Global.borderColor,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Global.gradient2,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "Select Bank",
                              ),
                              items:banknames
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    //style: TextStyle(fontSize: 30),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }
                      else
                        {
                          return const Text("");
                        }
                    }
                    else
                      {
                        return const Text("");
                      }
                    
                  }),
              const SizedBox(height: 10,),
              LoginField(
                hintText: accholdertxt,
                controller: bene_name,
                validationBuilder: ValidationBuilder().minLength(4),
                textInputType: TextInputType.name,
              ),
              const SizedBox(height: 10,),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  validator: ValidationBuilder().minLength(10).build(),
                  controller: bene_phone,
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.all(27),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Global.borderColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Global.gradient2,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    hintText: accountxt,
                    labelText: accountxt
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: TextFormField(
                  onTapOutside: (text){
                    if (bene_cphone.text != bene_phone.text) {
                      mactched=true;
                    }


                  },
                  onChanged: (accnum){


                    //print(accnum.length);
                  },
                  keyboardType: TextInputType.phone,
                  validator: ValidationBuilder().minLength(10).build(),
                  controller: bene_cphone,
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.all(27),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Global.borderColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Global.gradient2,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: "Confirm $accountxt",
                      labelText: "Confirm $accountxt"
                  ),
                ),
              ),
              Visibility(visible:mactched,child: const Text("Account number not matched",style: TextStyle(color: Colors.red),)),


              Visibility(
                visible: ghannastatus,
                child: const SizedBox(
                  height: 10,
                ),
              ),
              Visibility(
                visible: ghannastatus,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: DropdownButtonFormField(
                    onChanged: (momotype) {
                      print(momotype);

                      setState(() {
                        dropdownValue2 = momotype!;
                      });
                    },
                    // controller: controller,
                    decoration: InputDecoration(
                      label: const Text("MOMO Type"),
                      border: const OutlineInputBorder(),
                      //contentPadding: EdgeInsets.all(27),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Global.borderColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Global.gradient2,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "MOMO Type",
                    ),
                    items: <String>['MOMO Type', 'Subscriber', 'Merchant']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          //style: TextStyle(fontSize: 30),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              LoginField(
                hintText: 'Reason for Sending',
                controller: reason,
                validationBuilder: ValidationBuilder().minLength(4),
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > step3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= step3,
        title: const Text("Finish"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("BankName : bank name"),
            const Text("Account Number : bank name"),
            const Text("Account Name : Account name"),
            const Text("Account Type  : Account Type"),
            const Text("Amount Recipient Gets  : Account Type"),
            const Divider(
              height: 20,
              color: Global.gradient3,
            ),

            const SizedBox(
              height: 20,
            ),
            const Text("If you don't have a screenshot use the form below and type the time the payment was sent to us and how much(Sending Wrong information will get your account banned"),
            const SizedBox(
              height: 20,
            ),

            Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Global.gradient1,
                      Global.gradient2,
                      Global.gradient3,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(7)),
              child: ElevatedButton(
                onPressed: () async {
                  if (validate1() && validate2()) {
                    final progess = ProgressHUD.of(context);
                    progess!.show();
                    double sendamt = double.parse(payAmount.text);
                    double getamt = double.parse(getAmount.text);
                    String? memail = FirebaseAccounts().auth.currentUser!.email;
                    String? mphone = phone.text.trim();
                    String beneficairyNum = bene_phone.text.trim();
                    String beneficairyName = bene_name.text.trim();
                   String insert=await Dbinsert().sendmoney(memail!, mphone, tocountry, fromcountry, sendamt, getamt, beneficairyNum, beneficairyName, reason.text, beneficairyNum, recipient_currency, sender_currency, dropdownValue2,bank);
                   print(insert);
                  if(insert=="Saved")
                    {
                      progess.dismiss();
                      setState(() {
                        currentStep=0;
                        //bene_name.clear();
                         payAmount.clear();
                         getAmount.clear();
                         countryCurrency.clear();
                         phone.clear() ;
                         bene_phone.clear();
                         bene_cphone.clear();
                         bene_name.clear();
                         momotype.clear();
                         reason.clear();
                      });
                    }
                  } else if (!validate1()) {
                    setState(() {
                      currentStep = step1;
                    });
                  } else if (!validate2()) {
                    setState(() {
                      currentStep = step2;
                    });
                  }

                  // progress!.show();
                  // print(validate());
                  //  await FirebaseAccounts().signup(email.text, password.text);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(395, 55),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  //'Sign in',
                  'Complete Payment',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
