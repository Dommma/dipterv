import 'package:dipterv/models/customer_model.dart';
import 'package:flutter/material.dart';

class ChosenCustomerPage extends StatelessWidget {
  CustomerModel customer;
  String salesmanName;

  ChosenCustomerPage(this.customer, this.salesmanName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 80,),
        Icon(Icons.account_circle, size: 150, color: Colors.blueAccent,),
        SizedBox(height: 10,),
        Text(customer.name,
          style: TextStyle(
              color: Colors.blue,
              fontSize: 30
          ),),
        SizedBox(height: 60,),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.blue,),
                  SizedBox(width: 15,),
                  Text(customer.mobileNumber,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                    ),
                    maxLines: 2,
                  )
                ],
              ),
              Divider(thickness: 1, height: 20,),
              Row(
                children: [
                  Icon(Icons.email_outlined, color: Colors.blue,),
                  SizedBox(width: 15,),
                  Text(customer.emailAddress,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                    ),
                    maxLines: 2,)
                ],
              ),
              Divider(thickness: 1, height: 20,),
              //SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.man, color: Colors.blue,),
                  SizedBox(width: 15,),
                  Text(salesmanName,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                    ),
                    maxLines: 2,)
                ],
              ),
            ],
          ),),
        SizedBox(height: 30,),
        ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              )),
            ),
            onPressed:() {
              Navigator.pop(context);
            },
            child: Text('Vissza'))
      ],
    ),
    )
    );
  }
}