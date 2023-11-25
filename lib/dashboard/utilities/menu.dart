
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gafatcash/dashboard/utilities/confirmation.dart';
import 'package:gafatcash/startup/controller/database.dart';
import 'package:gafatcash/startup/controller/routes.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';



import '../../startup/controller/accounts.dart';
class Menus{

  final Stream<QuerySnapshot> usersStream = Dbinsert().db.collection('sendmoney').snapshots();
  static PopupMenuItem buildPopupMenuItem(String title, IconData iconData,BuildContext context) {
    return PopupMenuItem(
      child:  GestureDetector(
        onTap: () {
          if(title=="Logout")
            {
               FirebaseAccounts().logout(context);
              Navigator.pushNamedAndRemoveUntil(context, Routes.pinscreen, (Route<dynamic> route) => false);
            }
        },
        child: Row(
          children: [
            Icon(iconData, color: Colors.black,),
            Text(title),
          ],
        ),
      ),
    );
  }
  //modal box for diplay of infoinformation
  void imagemodal(context,String imagetxt,String key) {
    showMaterialModalBottomSheet(backgroundColor:Colors.black,bounce:false,context: context, builder: (BuildContext bc) {
      //Widget image = Image.memory(byteImage);
      return Consumer<FirebaseAccounts>(builder: (BuildContext context, FirebaseAccounts value, Widget? child) {

        return SingleChildScrollView(
          child: Consumer<FirebaseAccounts>(
            builder: (context, data, child) {
              return Container(
                height: 700,
                decoration: const BoxDecoration(
                  border: Border.symmetric(),
                  borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  color: Colors.white,

                ),
                // Define padding for the container.
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                // Create a Wrap widget to display the sheet contents.
                child: SingleChildScrollView(
                  child: Wrap(
                    children:[
                      // Add a container with height to create some space


                           Container(child: Image.network(imagetxt),)

                      // Add a row widget to display buttons for closing and reading more.
                    ],
                  ),
                ),


              );
            },
          ),
        );
      },
      );

    }
    );
  }

  void showSheet(context,String tdate,String reason,String tid,String status,String img,String sendcountry,String recipeintcountry,double sendamount,double getamount,String sentcurrency,String receivingcurrency,String recipientcontact,String recipientname,String key) {
    // Show a modal bottom sheet with the specified context and builder method.
    bool pendinstatus=true;
    if(status!="pending")
    {
      pendinstatus=false;
    }
    else
    {
      pendinstatus=true;

    }


    showMaterialModalBottomSheet(backgroundColor:Colors.black,context: context, builder: (BuildContext bc) {

      return Consumer<FirebaseAccounts>(
        builder: (BuildContext context, FirebaseAccounts value, Widget? child) {
          return ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth: 400
            ),
            child: Builder(
                builder: (context) {
                  return Container(
                    // Define padding for the container.
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)
                        )
                    ),
                    // Create a Wrap widget to display the sheet contents.
                    child: Wrap(
                      spacing: 30, // Add spacing between the child widgets.
                      children:[
                        // Add a container with height to create some space.
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [

                                  Expanded(
                                    flex: 1,
                                    child: Row(

                                      children: [

                                        Expanded(child:TextButton(onPressed: (){
                                          imagemodal(context, img,key);
                                        }, child: const Icon(Icons.image_search)))
                                        // TextButton.icon(onPressed: (){
                                        //   Navigator.pop(context);
                                        //
                                        //  // calculator(context,density,pounds,karat,perpound,total,key,grams,volume,price);
                                        // },
                                        //   icon: const Icon(Icons.edit,color: Colors.orange,), label: const Text("Edit"),
                                        // )
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: pendinstatus,
                                    child: Expanded(
                                      flex: 1,
                                      child: TextButton.icon(onPressed: () async {
                                        final del=await confirmation(context, title: ("Delete Record"), content: ("Do you want to delete this record"), textOK: ("Yes"), textCancel: ("No"));
                                        if(del)
                                        {
                                          Navigator.pop(context);
                                          Dbinsert().db.collection("sendmoney").doc(key).delete();
                                        }


                                      },
                                        icon: const Icon(Icons.delete_forever_sharp,color: Colors.red,), label: const Text(""),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            Visibility(
                              visible: pendinstatus,
                              child: Expanded(
                                flex: 1,
                                child: Row(
                                  children: [

                                  TextButton.icon(onPressed: () async {
                                   // modalimageupload(context, img,key);


                                      //  File file=File(platform.);

                                    },
                                      icon: const Icon(Icons.upload_file,color: Colors.green,), label: const Text("Upload",style: TextStyle(color: Colors.black38),),
                                    )

                                  ],
                                ),
                              ),
                            )

                          ],

                        ),
                        const Divider(thickness: 5,color: Colors.black12,),
                        // Add a text widget with a title for the sheet.
                        const Text("Record Details ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                        Container(height: 10), // Add some more space.
                        const Divider(thickness: 1,color: Colors.black38,),

                        // Add a text widget with a long description for the sheet.
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Transaction ID:',
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                                Text(tid,
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1,color: Colors.black38,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Transaction Date:',
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                                Text(tdate,
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1,color: Colors.black38,),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sent Country:',
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                                Text(sendcountry,
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1,color: Colors.black38,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Recipient Country:',
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                                Text(recipeintcountry,
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1,color: Colors.black38,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sent Amount',
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                                Text('$sendamount',
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1,color: Colors.black38,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Recipient Amount',
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                                Text('$getamount',
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1,color: Colors.black38,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Recipient Name',
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                                Text(recipientname,
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1,color: Colors.black38,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Recipient Contact',
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                                Text(recipientcontact,
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1,color: Colors.black38,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Reason for sending Money:',
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                                Text(reason,
                                  style: TextStyle(
                                      color: Colors.grey[600], // Set the text color.
                                      fontSize: 14 // Set the text size.
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),

                        Container(height: 10), // Add some more space.
                        // Add a row widget to display buttons for closing and reading more.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end, // Align the buttons to the right.
                          children: <Widget>[
                            // Add a text button to close the sheet.
                            TextButton(
                              style: TextButton.styleFrom(foregroundColor: Colors.transparent,), // Make the button text transparent.
                              onPressed: (){
                                Navigator.pop(context); // Close the sheet.
                              },
                              child: Text("Close", style: TextStyle(color: Theme.of(context).colorScheme.primary)), // Add the button text.
                            ),
                            // Add an elevated button to read more.

                          ],
                        )
                      ],
                    ),
                  );
                }
            ),
          );
        },

      );
    });
  }

}
