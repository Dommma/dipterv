import 'package:dipterv/route/customer/customer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'customer_bloc.dart';

class CustomerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomerState();
}

class _CustomerState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, CustomerState>(
        listener: (context, state) {},
        builder: (context, state) {
          var currentState = state;
          if(currentState is CustomerLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(currentState is CustomerBasicState) {
            if(currentState.customers == null) {
              return Center(
                child: Text('Üres a munkatársak listája'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: ListView.builder(
                    itemCount: currentState.customers?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomerListItem(currentState.customers![index]);
                    }),
              );
            }
          } else {
            return Container();
          }
        });
  }

}