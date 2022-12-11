import 'package:flutter/material.dart';

class NavBarListTileWidget extends StatelessWidget {
  String currentPage, title;
  IconData icon;
  Widget direction;

  NavBarListTileWidget({ required this.currentPage, required this.title, required this.icon, required this.direction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          if(currentPage == title) {
            Navigator.pop(context);
          }
          else {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => direction), (route) => false);
          }
        },
        tileColor: currentPage == title ? Colors.blue : null,
        iconColor: currentPage == title ? Colors.white : null,
        textColor: currentPage == title ? Colors.white : null,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
        ),
      ),
    );
  }

}