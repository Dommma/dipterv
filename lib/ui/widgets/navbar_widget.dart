import 'package:dipterv/ui/pages/login_page.dart';
import 'package:dipterv/ui/widgets/exit_dialog.dart';
import 'package:flutter/material.dart';

import '../styles/custom_colors.dart';

class NavBarWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("Harmat Dominik", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
              accountEmail: Text("dominik.harmat@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network("https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                      fit: BoxFit.cover
                  )
                ),
              ),
            decoration: BoxDecoration(
              color: Colors.blueAccent
            ),
          ),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: const Text("Levelek"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.house_outlined),
            title: const Text("Ingatlanok"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.man_2_outlined),
            title: const Text("Ügyfelek"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text("Naptár"),
            onTap: () {},
          ),
          Divider(color: Colors.blueAccent,),
          ListTile(
            leading: Icon(Icons.logout, color: CustomColor.mainColor),
            title: const Text("Kijelentkezés"),
            onTap: () async {
              showDialog(context: context, 
                  builder: (context) => AlertDialog(
                    title: Text("Biztosan ki akarsz jelentkezni?"),
                    actions: [
                      TextButton(
                          onPressed: () {Navigator.pop(context, false);}, 
                          child: Text("Nem")),
                      TextButton(
                          onPressed: () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);},
                          child: Text("Igen")),
                    ],
                  ));
            },
          ),
        ],
      ),
    );
  }

}