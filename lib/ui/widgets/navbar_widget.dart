import 'package:dipterv/bloc/authentication/auth_cubit.dart';
import 'package:dipterv/services/constans.dart';
import 'package:dipterv/ui/pages/calendar/calendar_page.dart';
import 'package:dipterv/ui/pages/customers_page.dart';
import 'package:dipterv/ui/pages/login_page.dart';
import 'package:dipterv/ui/pages/real_estate_page.dart';
import 'package:dipterv/ui/widgets/exit_dialog.dart';
import 'package:dipterv/ui/widgets/navbar_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../styles/custom_colors.dart';

class NavBarWidget extends StatelessWidget {
  String currentPage;

  NavBarWidget({required this.currentPage});

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
              backgroundImage: NetworkImage("${filePath}${state.userModel.collectionId}/${state.userModel.id}/${state.userModel.avatar}"),
            ),
            decoration: const BoxDecoration(
                color: Colors.blue
            ),
          ),
          NavBarListTileWidget(
              currentPage: currentPage,
              title: "Real estates",
              icon: Icons.house_outlined,
              direction: RealEstatePage(),),
          NavBarListTileWidget(
              currentPage: currentPage,
              title: "Customers",
              icon: Icons.man_2_outlined,
              direction: CustomersPage(),),
          NavBarListTileWidget(
              currentPage: currentPage,
              title: "Calendar",
              icon: Icons.calendar_month_outlined,
              direction: CalendarPage(),),
          const Divider(color: Colors.blueAccent,),
          ListTile(
            leading: Icon(Icons.logout, color: CustomColor.mainColor),
            title: const Text("Log out"),
            onTap: () async {
              showDialog(context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                          onPressed: () {Navigator.pop(context, false);},
                          child: const Text("No")),
                      TextButton(
                          onPressed: () {
                            context.read<AuthCubit>().logoutUser();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                            },
                          child: const Text("Yes")),
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