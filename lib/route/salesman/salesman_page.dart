import 'package:dipterv/route/salesman/salesman_bloc.dart';
import 'package:dipterv/route/salesman/salesman_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesmanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SalesmanState();
}

class _SalesmanState extends State<SalesmanPage> {
  SalesmanBloc get _bloc => context.read<SalesmanBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesmanBloc, SalesmanState>(
        listener: (context, state) {},
        builder: (context, state) {
          var currentState = state;
          if(currentState is SalesManLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(currentState is SalesmanBasicState) {
            if(currentState.salesmans == null) {
              return Center(
                child: Text('Salesman list is empty!'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: ListView.builder(
                    itemCount: currentState.salesmans?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SalesmanListItem(
                          salesman: currentState.salesmans![index],
                          callEvent: () {_callEvent(currentState.salesmans![index].mobileNumber);},
                          emailEvent: () {_emailEvent(currentState.salesmans![index].emailAddress);});
                    }),
              );
            }
          } else {
            return Container();
          }
        });
  }

  void _callEvent(String mobileNumber) {
    _bloc.add(SalesmanCallEvent(mobileNumber));
  }

  void _emailEvent(String emailAddress) {
    _bloc.add(SalesmanEmailEvent(emailAddress));
    }

}