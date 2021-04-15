


import 'package:customer_app/models/usermodel.dart';
import 'package:customer_app/service/network_request.dart';
import 'package:customer_app/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

class LoginViewmodel extends BaseViewModel{

  NetworkRequest req = NetworkRequest();
  bool isLoading = false;

  startLoading(){
    isLoading = true;
    notifyListeners();
  }

  stopLoading(){
    isLoading = false;
    notifyListeners();
  }

  login(context,Map data) async{

    startLoading();
    CustomResponse response = await req.postRequest('/login',data);
    stopLoading();
    if(response.statusCode == 200){
      if(response.data['code'] == 200){
      User user = User.fromJson(response.data['data']);
      req.setUserData(user);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home() ));
      } else {
        Fluttertoast.showToast(msg: response.message,toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.red);
      }
    } else {
      Fluttertoast.showToast(msg: response.message,toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.red);
    }
  }

}