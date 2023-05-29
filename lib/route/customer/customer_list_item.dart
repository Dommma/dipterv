import 'dart:ui';

import 'package:dipterv/core/locator.dart';
import 'package:dipterv/models/customer_model.dart';
import 'package:dipterv/route/customer/chosen_customer_page.dart';
import 'package:dipterv/services/salesman_service.dart';
import 'package:flutter/material.dart';

class CustomerListItem extends StatelessWidget {
  final CustomerModel customer;
  final _salesmanService = locator.get<SalesmanService>();

  CustomerListItem(this.customer);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            var salesman = await _salesmanService.getChosenSalesman(customer.salesman);
            Navigator.push(context, MaterialPageRoute(builder: (_) => ChosenCustomerPage(customer, salesman.name)));
          },
          child: Card(
            elevation: 10,
            shadowColor: Colors.black,
            child: ListTile(
              leading: Icon(Icons.account_circle, size: 50, color: Colors.blue,),
              title: Text(customer.name),
              subtitle: Text(customer.mobileNumber),
              trailing: Icon(Icons.arrow_forward_ios)
            ),
          ),
        ),
        SizedBox(height: 5,)
      ],
    );
  }

}