import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'customer_details_viewmodel.dart';

class CustomerDetails extends StatelessWidget {
  final id;

  TextEditingController _controller = TextEditingController();
   CustomerDetails({Key key, this.id}) : super(key: key);

    _showBottomSheet(context,model){
    showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Update card name',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold),),
              SizedBox(height: 10,),
              TextField(
                controller: _controller,

              ),
              ElevatedButton(onPressed: (){
                if(_controller.text.isNotEmpty)
                  model.updateName(model.customer.cardCode,_controller.text);
                  Navigator.pop(context);
              } , child: Text('update'))
            ],
          ),
        );
    } );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerDetailsViewmodel>.reactive(
      onModelReady: (model){
        print("id $id");
        model.getData(id);
      },
        builder: (context, model, child) => WillPopScope(
          onWillPop: ()async{
            if(model.updated){
              Navigator.pop(context,true);

            } else {
              Navigator.pop(context,false);
            }
            return true;
          },
                  child: Scaffold(
                appBar: AppBar(
                  title: Text('Customer Details'),
                ),
                body: model.isLoading? Center(child: CircularProgressIndicator(),) : Card(
                    child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(child: Text('${model.customer.cardName}',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold),)),
                        IconButton(
                            icon: Icon(Icons.edit_attributes), onPressed: () {
                              _showBottomSheet(context, model);
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Card code ${model.customer.cardCode}'),
                    Text('Address ${model.customer.address}'),
                    Text('price Mode ${model.customer.priceMode}'),
                  ]),
                )),
              ),
        ),
        viewModelBuilder: () => CustomerDetailsViewmodel());
  }

}
