
import 'dart:convert' as convert;
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gafatcash/global.dart';
import 'package:gafatcash/startup/controller/accounts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../startup/components/login_field.dart';
import '../../startup/controller/database.dart';
import 'package:flutter/services.dart';

import '../../startup/controller/routes.dart';



class FormPage extends StatefulWidget {
   const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAccounts().ngbanks();

}
  final Stream<QuerySnapshot> _usersStream = Dbinsert().db.collection('convert').snapshots();
 // File? displayfile;
  bool loading=true;
  final _moneyform1 = GlobalKey<FormState>();
  final _moneyform2 = GlobalKey<FormState>();

    bool bankshow=false;
    bool momoshow=false;
    bool chatshow=false;
    bool amounts=false;
    bool isChecked=false;
    bool isError=false;
    bool paymodeshoe=true;



bool ghannastatus=true;
  bool tonigeria=false;
  bool continuestatus=true;
  bool imagestatus=true;
  bool progressbtn=true;
  String dropdownValue2 = 'MOMO Type';
  String bankname ="";
  String bankcode="";
  String errortxt="";
  String reference="";
  String image="";
  String paymentmode="Bank Transfer";
  List testitem=["items","Item2"];

  double toconverted=0;
  double fromconverted=0;
  bool showagreement=false;

  int step1 = 0;
  int step2 = 1;
  int step3 = 2;

  var matched=false;

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
      barrierColor: Colors.white10,
      child: Consumer<FirebaseAccounts>(
        builder: (BuildContext context, FirebaseAccounts value, Widget? child) {
          if(currentStep==2){
            progressbtn=false;
          }
          else
            {
              progressbtn=true;


            }
          return Container(
              color: Global.backgroundColor,
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Stepper(
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepTapped: (step) => setState(() {
                    currentStep = step;
                  }),
                  controlsBuilder: (context,_) {
                    return Visibility(
                      visible: progressbtn,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
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

                                      if(validate1() && isChecked){
                                        setState(() {
                                          currentStep=step2;
                                        });
                                      }
                                      else if(!isChecked)
                                          {
                                            isError=true;
                                            SnackBar snack=const SnackBar(content: Text("Please check on the checkbox to agree before your continue to step two",style: TextStyle(color:Colors.red),));
                                            ScaffoldMessenger.of(context).showSnackBar(snack);
                                          }


                                    }
                                  else if(currentStep==step2)
                                    {
                                      if(validate2()){
                                        setState(() {
                                          currentStep=step3;
                                        });
                                      }
                                      // bool stage2=validate2();
                                      // if(bene_cphone.text!=bene_phone.text)
                                      //   {
                                      //     bene_phone.selection.start.sign;
                                      //     stage2=false;
                                      //   }
                                      //  // print(stage2);

                                    }
                                  if(currentStep==step3)
                                    {
                                     // progressbtn=false;
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
                        ),
                      ),
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
                        List<double> fromvalue = [];
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
                            scurrencies.add(snapshot.data!.docs[i]['sendercurrency']);
                            rcurrencies.add(snapshot.data!.docs[i]['recipientcurrency']);
                            fromc.add(snapshot.data!.docs[i]['from']);
                            countries.add(name);
                            items.add(name);
                          }
                        } else {}

                        return Container(
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
                            onTap: ()async {
                              await  value.ngbanks();

                            },
                            onChanged: (text) {
                              momoshow=false;
                              chatshow=false;
                              if(text!.toLowerCase()=="send to ?") {amounts=false;}
                              else {amounts=true;}
                              getAmount.clear();
                               payAmount.clear();
                               showagreement=false;
                              for (int i = 0; i < tovalue.length; i++) {
                                if (text == countries[i]) {
                                  tocountry = text!;
                                  fromcountry = fromc[i];
                                  sender_currency = scurrencies[i];
                                  recipient_currency = rcurrencies[i];
                                  scale = tovalue[i];
                                  if(tocountry.toLowerCase()=="nigeria"){
                                    setState(() {
                                      bankshow=true;
                                      paymodeshoe=true;
                                      accholdertxt="Name of Beneficiary";
                                      accountxt="Account Number";
                                      ghannastatus=false;
                                      tonigeria=true;
                                    });
                                  }
                                  else
                                    {
                                      setState(() {
                                        ghannastatus=true;
                                        tonigeria=false;
                                        paymodeshoe=false;

                                        accountxt="Mobile Money Number";
                                        accholdertxt="Mobile Money Name";
                                      });

                                    }
                                }
                              }
                              //print( await value.countries());
                            },
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
              TextFormField(
                enabled: amounts,
                controller: payAmount,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: ValidationBuilder().minLength(1).build(),
                onChanged: (amount) {

                  setState(() {

                    if (amount.isNotEmpty) {
                      double fsm = double.parse(amount);
                      sendingamount = fsm;
                      recievedamount =Convert.truncateToDecimalPlaces((sendingamount * scale), 1);
                      getAmount.text = "$recievedamount";
                      agreement = "You are confirming that we will be sending  ${sender_currency} ${payAmount.text}  and the recipient will receive  ${recipient_currency} ${getAmount.text} ";
                      showagreement=true;
                    }
                    else
                    {
                      getAmount.text="0";
                      agreement="";
                      showagreement=false;


                    }

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
              const SizedBox(
                height: 10,
              ),
              //Amount Recipient get
              TextFormField(
                enabled: amounts,
                controller: getAmount,
                keyboardType: TextInputType.number,
                validator: ValidationBuilder().minLength(1).build(),
                onChanged: (amount) {

                  double? convertedvalue;

                  setState(() {

                    if(amount.isNotEmpty) {
                      double cov_value=double.parse(amount);
                      convertedvalue =cov_value!/(scale);
                      recievedamount;
                      double finalreverse=Convert.truncateToDecimalPlaces(convertedvalue!, 1);
                      payAmount.text="$finalreverse";
                      agreement = "You are confirming that we will be sending  $sender_currency ${payAmount.text}  and the recipient will receive  $recipient_currency ${getAmount.text} ";
                      showagreement=true;
                    }
                    else{
                      payAmount.text="0";
                      agreement = "";
                      showagreement=false;

                    }

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
              const SizedBox(
                height: 10,
              ),
              //Your currency
              TextFormField(
                controller: phone,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: ValidationBuilder().minLength(10).build(),
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
              const SizedBox(
                height: 10,
              ),
            Visibility(
              visible: showagreement,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Checkbox(

                    isError: isError,
                    value: isChecked,
                    onChanged: (bool? value) {
                      isChecked=value!;
                      setState(() {
                        if(!isChecked){
                          currentStep=0;
                          isChecked = false;

                        }
                      });
                    },
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      agreement,
                      style: const TextStyle(color: Colors.amber),
                    ),
                  ),
                ],
              ),
            )

            ],
          ),
        ),
      ),
      Step(
        state: currentStep > step2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= step2,
        title: const Text("Beneficiary"),
        subtitle: const Text("Information"),
        content: Consumer<FirebaseAccounts>(

          builder: (BuildContext context, FirebaseAccounts value, Widget? child) {

           // value.ngbanks();
            return Form(
              key: _moneyform2,
              child: Column(
                children: [
                //nigerian banks
                  Visibility(
                    visible: tonigeria,
                    child: DropdownSearch<String>(
                      dropdownDecoratorProps:  DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintText: "Recipient Bank",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          
                        )

                      ),

                      popupProps:const PopupProps.dialog(
                        fit: FlexFit.loose,
                        title: Text("Search for Recipient bank",style: TextStyle(),),
                        showSearchBox: true,
                      ),
                      items: value.banks,
                      onChanged: (val) async {
                        int posbank=value.banks.indexOf(val!);
                        bankcode=value.bankscode[posbank];
                        bank=val;
                        //(val);

                        if(bene_phone.text.isNotEmpty){
                          await value.ngbankverify(bene_phone.text, bankcode,tocountry);
                          errortxt=value.accountnotfoundtxt;
                          matched=value.matched;
                          bene_name.text=value.accname;
                          momotype.text=value.momotype;

                        }
                      },
                      selectedItem: bank,
                      validator: (String? item) {
                        if (item == null) {
                          return "Required field";
                        } else if (item == "Brazil")
                        {return "Invalid item";}
                        else{
                          return null;

                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 10,),
                //beneficiary account/phone
                  TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.phone,
                    validator: ValidationBuilder().minLength(10).build(),
                    controller: bene_phone,
                    onChanged: (cphone) async {
                      await value.ngbankverify(bene_phone.text, bankcode,tocountry);
                      errortxt=value.accountnotfoundtxt;
                      matched=value.matched;
                      bene_name.text=value.accname;
                      momotype.text=value.momotype;
                     // print(value.accname);

                    },
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
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.name,
                    validator: ValidationBuilder().minLength(4).build(),
                    controller: bene_name,
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
                        hintText: accholdertxt,
                        labelText: accholdertxt
                    ),
                  ),
                  const SizedBox(height: 10,),
                 Visibility(visible:matched,child: Text(errortxt,style: const TextStyle(color: Colors.red),)),
                  Visibility(
                    visible: ghannastatus,
                    child: const SizedBox(
                      height: 10,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: ValidationBuilder().minLength(4).build(),
                    controller: momotype,
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
                        hintText: "Account Type",
                        labelText: "Account Type"
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Reason for sending Money
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: ValidationBuilder().minLength(4).build(),
                    controller: reason,
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
                        hintText: "Input reason for sending the money",
                        labelText: "Reason"
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Visibility(
                    visible: paymodeshoe,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: "Payment Mode",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),

                      ),

                      value: null,
                        items: ["MOMO","Allow Cash Out","Bank Transfer"].map((e) => DropdownMenuItem(
                      value: e,
                      child:Text(e) ,
                    )).toList(),
                        onChanged: (value){
                        if(value=="MOMO")
                          {
                            momoshow=true;
                          }
                          else
                            {
                              momoshow=false;
                            }

                         if(value=="Allow Cash Out")
                          {
                            chatshow=true;
                          }
                         else
                           {
                             chatshow=false;
                           }
                         if(value=="Bank Transfer"){
                          bankshow=true;
                        }else
                          {
                            bankshow=false;
                          }
                        paymentmode=value!;

                        }),
                  ),
                ],
              ),
            );

          },
        ),
      ),
      Step(
        state: currentStep > step3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= step3,
        title: const Text("Finish"),
        content: Consumer<FirebaseAccounts>(
          builder: (BuildContext context, FirebaseAccounts value, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: bankshow,
                  child: const Card(
                    color: Colors.white10,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("BankName : bank name"),
                          Text("Account Number : XXXXXXXXXX"),
                          Text("Account Name : Account name"),
                          Text("Account Type  : Account Type"),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: momoshow,
                  child:  const Card(
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("MOMO Number :XXXXXXXXXX"),
                          Text("MOMO Name : XXXXXXXXXXXX"),

                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: chatshow,
                  child:  Card(
                    child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextButton.icon(onPressed: () async {
                            try{
                              final Uri _url = Uri.parse('https://tawk.to/chat/655f776cda19b36217901780/1hfuel158');
                              launchUrl(_url);

                            }catch (e){
                              print("Erro $e");

                            }

                           // Navigator.pushNamed(context, Routes.charts);
                           //await Livechat.beginChat("LICENSE_NO", "GROUP_ID", "VISITOR_NAME", "VISITOR_EMAIL");

                          },icon:const Icon(Icons.chat), label: const Text("Chat Us"),)

                        ],
                      ),
                    ),
                  ),
                ),


                const Divider(
                  height: 20,
                  color: Global.gradient3,
                ),
                Visibility(visible: imagestatus,child: value.newdisplayfile(),),

                ElevatedButton(onPressed: () async{
                  final progress=ProgressHUD.of(context);
                  progress?.show();
                  value.getConnectionType();
                  // Future.delayed(const Duration(seconds: 10),()=>{
                  //   progress!.dismiss()
                  // });
                  await value.newupload();
                  progress!.dismiss();
                  image=value.imageUrl;
                  if(image.isNotEmpty){
                    imagestatus=true;
                  }

                 // fileupload();

                }, child: const Text("Upload Payment Evidence")),

                // Image.file(displayfile!),
                const SizedBox(
                  height: 20,
                ),
                const Text("If you don't have a screenshot use the form below and type the time the payment was sent to us and how much(Sending Wrong information will get your account banned"),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value){
                    reference=value;
                  },
                  keyboardType: TextInputType.name,

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
                      hintText: "Payment Reference",
                      labelText: "Payment Reference(Note)"
                  ),
                ),
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
                        image=value.imageUrl;
                        String insert=await Dbinsert().sendmoney(paymentmode,reference,image,memail!, mphone, tocountry, fromcountry, sendamt, getamt, beneficairyNum, beneficairyName, reason.text, beneficairyNum, recipient_currency, sender_currency, momotype.text,bank);
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
                            bank="";
                            // bene_cphone.clear();
                            bene_name.clear();
                            momotype.clear();
                            reason.clear();
                            imagestatus=false;
                            image="";
                            reference="";
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
            );
          },
        ),
      ),
    ];
  }
}
