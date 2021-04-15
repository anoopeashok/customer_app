

import 'package:flutter/material.dart';

errorDialogBox(context,message){
  AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children:[
        Icon(Icons.error,size: 60,),
        SizedBox(
          height: 20,
        ),
        Text('$message'),
      ]
    ),
    actions: [
      TextButton(
        onPressed: ()=> Navigator.pop(context),
        child: Text('Close'),
      )
    ],
  );
}