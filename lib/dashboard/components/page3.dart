import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gafatcash/dashboard/dbModels/dbcrud.dart';
import 'package:gafatcash/startup/controller/dbfields.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../startup/controller/accounts.dart';
import '../../startup/controller/database.dart';
import '../utilities/menu.dart';
class Page3 extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}
class _UserInformationState extends State<Page3> {
  Widget status=TextButton.icon(onPressed: null,icon: Icon(Icons.done_all,color: Colors.blue[500],), label: Text("Received",style: TextStyle(color: Colors.blue[500]),),);
  final Stream<QuerySnapshot> _usersStream = Dbinsert().db.collection('sendmoney').where('email',isEqualTo:'${FirebaseAccounts().auth.currentUser!.email}').orderBy('tid',descending: true).snapshots();
  @override
  Widget build(BuildContext context) {
    
    return Consumer(
      builder: (context, value,  child) {
        return StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if(!snapshot.hasData)
              {
                return const Text('Loading Data',style: TextStyle(color: Colors.white),);
              }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            return Padding(

              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  Widget statustxt;
                  Icon statusicon=const Icon(Icons.done_all);
                  if(data['status']=="pending")
                  {
                    statustxt=const Text("pending");
                    statusicon=const Icon(Icons.done_all);
                  }
                  else if(data['status']=="ready"){
                    statustxt= const Text("processing",style: TextStyle(color: Colors.brown));
                    statusicon=const Icon(Icons.done_all,color: Colors.brown,);
                  }
                  else if(data['status']=="received"){
                    statustxt= Text("Received",style: TextStyle(color: Colors.blue[600]),);
                    statusicon= Icon(Icons.done_all,color: Colors.blue[600],);



                  }
                  else{
                    statustxt=const Text("Error");
                  }
                    {
                      status=TextButton.icon(onPressed: null,icon: statusicon, label: statustxt,);
                      return Card(
                        shape: const RoundedRectangleBorder(),
                        elevation: 2,
                        color: Colors.white10,
                        child: ListTile(
                          onTap: (){
                            String sendcountry=data[Dbfield.fromcountry];
                            String recipeintcountry=data[Dbfield.tocountry];
                            double sendamount=data[Dbfield.sendamount];
                            double getamount=data[Dbfield.getamount];
                            String sentcurrency=data[Dbfield.sendcurrency];
                            String receivingcurrency=data[Dbfield.receivecurrency];
                            String recipientcontact=data[Dbfield.receipientphone];
                            String recipientname=data[Dbfield.reciname];
                            String? image=data[Dbfield.image];
                            String status=data[Dbfield.status];
                            String date=data[Dbfield.date];
                            String reason=data[Dbfield.reason];
                            int tid=data[Dbfield.tid];
                            String key=document.id;
                            if(image!.isEmpty){
                              image="";

                            }
                            Menus().showSheet(context,date,reason,"$tid",status,image!, sendcountry, recipeintcountry, sendamount, getamount, sentcurrency, receivingcurrency, recipientcontact, recipientname,key);
                            //  FirebaseAccounts().db.collection("transactions").doc(document.id).delete();
                          },
                          iconColor: Colors.amber,
                          leading: const Icon(Icons.calculate,color: Colors.white10,size: 50,),
                          title: Text(data[Dbfield.reciname],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.amber),),
                          subtitle: Text("Sent Amount: ${data['sendamount']}",style: const TextStyle(color: Colors.white54),),
                          trailing:status,
                        ),

                      );
                    }



                })
                    .toList()
                    .cast(),
              ),
            );
          },
        );
      }
    );

  }
}
