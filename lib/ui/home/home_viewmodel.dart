import 'package:customer_app/models/customer.dart';
import 'package:customer_app/service/network_request.dart';
import 'package:customer_app/service/sqflite_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

class HomeViewmodel extends BaseViewModel {
  bool isLoading = true;
  List<Customer> customers = [];
  LocalDatabase database = LocalDatabase();
  NetworkRequest request = NetworkRequest();

  getData() async {
    await database.open();
    await getDataFromDB();
    if (customers.isEmpty) {
      getDataFromServer();
    }
    isLoading = false;
    notifyListeners();
  }

  getDataFromServer() async {
    var response = await request.getRequest('/customerList/${request.user.id}');
    print(response.data['data']);
    if (response.statusCode == 200) {
      if (response.data['code'] == 200) {
        List list = response.data['data'];
        list.forEach((element) {
          customers.add(Customer.fromJson(element));
          database.insertData(Customer.fromJson(element));
         });
      } else {
        Fluttertoast.showToast(
            msg: response.message,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red);
      }
    }
  }

  getDataFromDB() async {
    customers = await database.fetchAllData();
  }
}
