import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gafatcash/global.dart';
import 'package:provider/provider.dart';
import '../../startup/controller/accounts.dart';
import '../../startup/controller/database.dart';
import './chart.dart';
import 'package:country_flags/country_flags.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {


    return  Consumer<FirebaseAccounts>(
      builder: (BuildContext context, FirebaseAccounts value, Widget? child) {
        String mymaiail='';
        print(value.auth.currentUser?.email);
        if(value.auth.currentUser!=null)
          {
             mymaiail=value.auth.currentUser!.email!;

          }
        else
          {
            value.logout(context);
          }



        final Stream<QuerySnapshot> usersStream = Dbinsert().db.collection('sendmoney').where('email',isEqualTo:'${mymaiail}').snapshots();

        return StreamBuilder<QuerySnapshot>(
            stream: usersStream,
            builder: (context, snapshot) {
              double ngpending=0;
              double ngrecieved=0;
              double ghpending=0;
              double ghrecieved=0;

              double pending=0;
              double recieved=0;

              int pdt=0;
              int pct=0;
              if(snapshot.hasData)
              {
                for(int i=0; i<snapshot.data!.size;i++)
                  {

                    String dbstatus=snapshot.data!.docs[i]['status'];
                    String tocountry=snapshot.data!.docs[i]['to'];
                    double toamount=snapshot.data!.docs[i]['sendamount'];
                    if(tocountry=="Ghana" && dbstatus=="pending")
                      {
                        ghpending+=toamount;
                      }
                    if(tocountry=="Ghana" && dbstatus=="received")
                    {
                      ghrecieved+=toamount;
                    }

                    //=======================Nigeria Stats===============
                    if(tocountry=="Nigeria" && dbstatus=="pending")
                    {
                      ngpending+=toamount;
                    }
                    if(tocountry=="Nigeria" && dbstatus=="received")
                    {
                      ngrecieved+=toamount;
                    }


                    if(dbstatus=="pending")
                      {
                        pdt+=1;
                        pending+=snapshot.data!.docs[i]['sendamount'];

                      }
                    else
                      {
                        pct++;
                        recieved+=snapshot.data!.docs[i]['sendamount'];

                      }
                  }
                //tgrams=snapshot.data!.docs[0]['Grams'];
              }
              else
                {
                  return const Text("No Data");
                }
              double ghtotal=ghrecieved+ghpending;
              double ngtotal=ngrecieved+ngpending;

              return Container(
                color: Global.backgroundColor,
                child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  // children: snapshot.data!.docs.map((DocumentSnapshot document)
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 200,
                            child:  GestureDetector(
                              onTap: () async {
                                //print(await value.totalgrams());
                              },
                              child:  Card(color: Global.bgColor,child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CountryFlag.fromCountryCode(
                                    'GH',
                                    height: 40,
                                    width: 40,
                                    borderRadius: 8,
                                    ),

                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                         Expanded(
                                           child: Text('Amount Sent to Ghana ',
                                            style: TextStyle(
                                                color: Colors.white, // Set the text color.
                                                fontSize: 12,fontWeight: FontWeight.bold // Set the text size.
                                            ),
                                        ),
                                         ),

                                      ],
                                    ),
                                    const Divider(thickness: 1,color: Colors.black38,),

                                    Row(
                                      children: [

                                        const Text('Confirmed ',
                                          style: TextStyle(
                                              color: Colors.white, // Set the text color.
                                              fontSize: 12 // Set the text size.
                                          ),
                                        ),
                                        Text("₦${ghrecieved}",
                                          style: const TextStyle(
                                              color: Colors.white, // Set the text color.
                                              fontSize: 12 // Set the text size.
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(thickness: 1,color: Colors.black38,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Text('Pending  ',
                                          style: TextStyle(
                                              color: Colors.white, // Set the text color.
                                              fontSize: 12 // Set the text size.
                                          ),
                                        ),
                                        Text("₦ $ghpending",
                                          style: const TextStyle(
                                              color: Colors.white, // Set the text color.
                                              fontSize: 12 // Set the text size.
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(thickness: 1,color: Colors.black38,),

                                    Row(
                                      children: [
                                        const Text('Total ',
                                          style: TextStyle(
                                              color: Colors.white, // Set the text color.
                                              fontSize: 12 // Set the text size.
                                          ),
                                        ),
                                        Text("₦ $ghtotal",
                                          style: const TextStyle(
                                              color: Colors.white, // Set the text color.
                                              fontSize: 12 // Set the text size.
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 200,
                            child:  GestureDetector(
                              onTap: () async {
                                //print(await value.totalgrams());
                              },
                              child:  Card(color: Global.bgColor,child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CountryFlag.fromCountryCode(
                                      'NG',
                                      height: 40,
                                      width: 40,
                                      borderRadius: 8,
                                    ),
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Expanded(
                                          child: Text('Amount Sent to Nigeria ',
                                            style: TextStyle(
                                                color: Colors.white, // Set the text color.
                                                fontSize: 12,fontWeight: FontWeight.bold // Set the text size.
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    const Divider(thickness: 1,color: Colors.black38,),


                                    Row(
                                      children: [

                                        const Text('Confirmed ',
                                          style: TextStyle(
                                              color: Colors.white, // Set the text color.
                                              fontSize: 12 // Set the text size.
                                          ),
                                        ),
                                        Text("GHC ${ngrecieved}",
                                          style: const TextStyle(
                                              color: Colors.white, // Set the text color.
                                              fontSize: 12 // Set the text size.
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(thickness: 1,color: Colors.black38,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Text('Pending  ',
                                          style: TextStyle(
                                              color: Colors.white, // Set the text color.
                                              fontSize: 12 // Set the text size.
                                          ),
                                        ),
                                        Text("GHC ${ngpending}",
                                          style: const TextStyle(
                                              color: Colors.white, // Set the text color.
                                              fontSize: 12 // Set the text size.
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(thickness: 1,color: Colors.black38,),

                                    Row(
                                      children: [
                                        const Text('Total ',
                                          style: TextStyle(
                                              color: Colors.white, // Set the text color.
                                              fontSize: 12 // Set the text size.
                                          ),
                                        ),
                                        Expanded(
                                          child: Text("GHC ${ngtotal}",
                                            style: const TextStyle(
                                                color: Colors.white, // Set the text color.
                                                fontSize: 12 // Set the text size.
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),),
                            ),
                          ),
                        ),

                      ],


                    ),
                    const Padding(
                      padding: EdgeInsets.all(2.0),
                    ),
                    Column(children: [

                      Card(elevation:20,color:Global.bgColor,child: Column(children: [
                        Pie(context,pdt.toDouble(),pct.toDouble()),
                         Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bookmark_rounded,color: Colors.green[900],size: 30,),
                              Expanded(child: const Text("Confirmed Transactions",style: TextStyle(color: Colors.white,fontSize: 12),)),
                              const SizedBox(width: 30,),
                              Icon(Icons.bookmark_rounded,color: Colors.orange,size: 30,),
                              Expanded(child: const Text("Pending Transactions",style: TextStyle(color: Colors.white,fontSize: 12),)),
                            ],
                          ),
                        )

                        ],) ,),



                    ],)
                  ],
                ),
              );
            }
        );
      },
    );
  }
}

//chart
