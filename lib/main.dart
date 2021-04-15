import 'package:customer_app/service/network_request.dart';
import 'package:customer_app/ui/home/home.dart';
import 'package:customer_app/ui/login/login.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyAppviewmodel>.reactive(
      onModelReady: (model){
        model.initilize();
      },
      builder: (context,model,child)=> MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:model.isLoading ? Container(
        color: Colors.white,
      ) :  model.isLoggedIn ?  Home() : Login() ,
    ) , viewModelBuilder: ()=>  MyAppviewmodel());
  }
}


class MyAppviewmodel extends BaseViewModel{

  NetworkRequest req = NetworkRequest();
  bool isLoggedIn = false;
  bool isLoading = true;

  initilize() async{
    var user =await req.getUserData();
    print("user data"+user.toString());
    if(user != null){
      isLoggedIn = true;
    }
    isLoading = false;
    notifyListeners();
  }
}

