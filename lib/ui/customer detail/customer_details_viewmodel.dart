import 'package:customer_app/models/customer.dart';
import 'package:customer_app/service/sqflite_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

class CustomerDetailsViewmodel extends BaseViewModel{

  Customer customer;
  LocalDatabase _database = LocalDatabase();
  bool isLoading = true;
  bool updated = false;

  startLoading() async{
    isLoading = true;
    notifyListeners();
  }

  stopLoading() async{
    isLoading = false;
    notifyListeners();
  }
  
  getData(id) async{
    startLoading();
    print("called");
    customer = await _database.fetchByID( id);
    print("callled");
    stopLoading();
  }

  updateName(id,name) async{
    startLoading();
    await _database.updateData(name, id);
    await getData(id);
    updated = true;
    Fluttertoast.showToast(msg: 'Card naem Updated',toastLength:Toast.LENGTH_LONG);
    stopLoading();

  }

}