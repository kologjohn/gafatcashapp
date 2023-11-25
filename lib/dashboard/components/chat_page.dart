import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gafatcash/global.dart';
import 'package:gafatcash/startup/controller/accounts.dart';
import 'package:gafatcash/startup/controller/database.dart';
import 'package:gafatcash/startup/controller/dbfields.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Uri _url = Uri.parse('https://tawk.to/chat/655de50391e5c13bb5b2a259/1hfrcd613');

  final messagecontroller=TextEditingController();
  String? email=FirebaseAccounts().auth.currentUser!.email;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Us"),),
      backgroundColor: Global.backgroundColor,
      bottomNavigationBar: _chatTextField(),
      body: Align(
         child: Align(
            alignment: Alignment.topRight,
            child: StreamBuilder<QuerySnapshot>(
              stream: Dbinsert().db.collection("messages").where(Dbfield.recipient,isEqualTo: email).orderBy('tid',descending: false).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
                if(snapshot.hasData)
                {
                  print("Has Data");
                }
                else if(snapshot.hasError){
                  print("Error Loading  Data");
                }
                else
                {
                  print("Loading Messages");
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                   // mainAxisAlignment: MainAxisAlignment.end,
                    children:  snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      Alignment alignment=Alignment.topRight;
                      if(data[Dbfield.messagetype]=="send")
                      {
                         alignment=Alignment.topLeft;
                        // msgwidget= Align(
                        //   alignment: Alignment.bottomLeft,
                        //   child: Card(elevation: 2,child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text("${data['message']}"),
                        //   ) ,),
                        // );
                        //statusicon=const Icon(Icons.done_all);
                         print(alignment);

                      }

                        //status=TextButton.icon(onPressed: null,icon: statusicon, label: statustxt,);
                        return Align(
                          alignment: alignment,
                          child: Card(elevation: 2,child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${data['message']}"),
                          ) ,),
                        );




                    })
                        .toList()
                        .cast(),
                  ),
                );
              }
            ),
          ),
      ),
    );
  }
  Widget _chatTextField(){
    return Container(
      color: Colors.black26,
      padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 14,
          bottom: MediaQuery.of(context).viewInsets.bottom
      ),
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.grey
        ),
        child:  Row(
          children: [
            Expanded(

                child: TextFormField(
                  controller: messagecontroller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type a message",
                    hintStyle: TextStyle(
                      fontSize: 12,
                    )
                  ),
                )
            ),
            GestureDetector(
              onTap: () async {

                _launchUrl();
                //
                // String message=messagecontroller.text;
                // await Dbinsert().sendmessage(message,email!,"kologjohndok@gmail.com","send");
                // await Dbinsert().chatroom(email!,"kologjohndok@gmail.com");
                // messagecontroller.clear();
              },
              child: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.send, color: Colors.white,),
              ),
            )
          ],
        ),
      ),
    );
  }



  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

}

