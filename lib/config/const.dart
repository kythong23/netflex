import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

const url_img = "assets/images/";
void failDialog(String title, String content,BuildContext context){
  AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      showCloseIcon: true,
      title: title,
      desc: content,
      btnOkColor: Colors.red,
      btnOkIcon: Icons.cancel,
      btnOkOnPress: (){
      }
  ).show();
}
void ShowDialog(String text,BuildContext context)
{
  showDialog(context: context, builder: (_) => AlertDialog(
    title: const Text('Message'),
    content: Text(text),
    actions: [
      TextButton(
        child: const Text('OK'),
        onPressed: () =>  Navigator.of(context, rootNavigator: true).pop('dialog'),
      )
    ],
  ));
}