import 'package:dipterv/models/salesman_model.dart';
import 'package:flutter/material.dart';

class SalesmanListItem extends StatelessWidget {
  final SalesmanModel salesman;
  final Function callEvent;
  final Function emailEvent;

  SalesmanListItem({required this.salesman, required this.callEvent, required this.emailEvent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 10,
          shadowColor: Colors.black,
          child: ListTile(
              leading: CircleAvatar(backgroundImage: Image.network(salesman.profilePicture).image, radius: 30,),
              title: Text(salesman.name),
              subtitle: Text(salesman.rank),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () => callEvent(),
                      icon: Icon(Icons.phone, color: Colors.green,)),
                  IconButton(
                      onPressed: () => emailEvent(),
                      icon: Icon(Icons.email_outlined, color: Colors.orange,))
                ],)
          ),
        ),
        SizedBox(height: 5,)
      ],
    );
  }

}