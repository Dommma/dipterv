import 'package:dipterv/ui/pages/login_page.dart';
import 'package:flutter/material.dart';

Future<bool?> showExitDialog(BuildContext context) => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
        title: Text("Biztosan ki akarsz jelentkezni?"),
        actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Nem")
            ),
            TextButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
                child: Text("Igen")
            )
        ],
));