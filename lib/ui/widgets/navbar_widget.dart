import 'package:dipterv/bloc/authentication/auth_cubit.dart';
import 'package:dipterv/services/constans.dart';
import 'package:dipterv/ui/pages/login_page.dart';
import 'package:dipterv/ui/widgets/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../styles/custom_colors.dart';

class NavBarWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    if(state is AuthLoggedInState) {
      return ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(state.userModel.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            accountEmail: Text(state.userModel.email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: Image.network("${filePath}${state.userModel.collectionId}/${state.userModel.id}/${state.userModel.avatar}",
                    fit: BoxFit.cover,
                  )
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blueAccent
            ),
          ),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: const Text("Mails"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.house_outlined),
            title: const Text("Real estates"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.man_2_outlined),
            title: const Text("Customers"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text("Calendar"),
            onTap: () {},
          ),
          Divider(color: Colors.blueAccent,),
          ListTile(
            leading: Icon(Icons.logout, color: CustomColor.mainColor),
            title: const Text("Log out"),
            onTap: () async {
              showDialog(context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                          onPressed: () {Navigator.pop(context, false);},
                          child: Text("No")),
                      TextButton(
                          onPressed: () {
                            context.read<AuthCubit>().logoutUser();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                            },
                          child: Text("Yes")),
                    ],
                  ));
            },
          ),
        ],
      );
    } else {
      return Container();
    }

  },
),
    );
  }

}