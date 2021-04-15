
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String username,password;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewmodel>.reactive(builder: (context,model,child)=> Scaffold(
      appBar: AppBar(
        title: Text('Customer App'),
        elevation: 0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Spacer(),
        Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Text(
                  'Login',
                )),
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            validator: (String val) {
                              if (val.isEmpty) {
                                return 'Please enter a  username';
                              } else{
                                username = val;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Username',
                                focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Please enter a password';
                              } else{
                                password = val;
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                                suffixIcon: Icon(Icons.view_agenda),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    model.isLoading ? Container(
                      height: 50,
                      child: Center(child: CircularProgressIndicator())) :  InkWell(
                      onTap: () {
                        bool isValidate = _formKey.currentState.validate();
                        if (isValidate) {
                          model.login(context, {"username": username,"password": password});
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ]),
    ), viewModelBuilder:()=> LoginViewmodel() );
  }
}
