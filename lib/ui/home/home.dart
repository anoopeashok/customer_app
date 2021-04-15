import 'package:customer_app/ui/customer%20detail/customer_detail.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
        onModelReady: (model) {
          model.getData();
        },
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Customers'),
              ),
              body: model.isLoading
                  ? CircularProgressIndicator()
                  : model.customers.isEmpty
                      ? Center(child: Text('No Data Found'))
                      : ListView.builder(
                          itemCount: model.customers.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: ListTile(
                                  onTap: () async{
                                    print("customer ${model.customers[index].toJson()}");
                                    var val = await Navigator.push(context, MaterialPageRoute(builder: (context)=>  CustomerDetails(id: model.customers[index].cardCode,)));
                                    if(val ?? false){
                                      
                                      model.getData();
                                    }
                                  },
                                  title:
                                      Text('${model.customers[index].cardName}'),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text(
                                        'Card code ${model.customers[index].cardCode}'),
                                    Text(
                                        'Address ${model.customers[index].address}')
                                  ]),
                                ),
                              ),
                            );
                          }),
            ),
        viewModelBuilder: () => HomeViewmodel());
  }
}
