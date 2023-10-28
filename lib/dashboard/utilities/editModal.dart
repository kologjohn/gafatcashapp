import 'package:flutter/material.dart';
class EditModal extends StatelessWidget {
  const EditModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: (){
          //ModalBottomSheet(expanded: true, child: null,);
        }, child: Text("Bottom"))
      ],
    );
  }
}
