import 'package:dipterv/route/calendar/calendar_bloc.dart';
import 'package:dipterv/route/calendar/calendar_page.dart';
import 'package:dipterv/route/customer/customer_bloc.dart';
import 'package:dipterv/route/customer/customer_page.dart';
import 'package:dipterv/route/profile/profile_bloc.dart';
import 'package:dipterv/route/profile/profile_page.dart';
import 'package:dipterv/route/realestate/real_estate_bloc.dart';
import 'package:dipterv/route/realestate/real_estate_page.dart';
import 'package:dipterv/route/salesman/salesman_bloc.dart';
import 'package:dipterv/route/salesman/salesman_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AuthRoot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthRootState();
}

class AuthRootState extends State<AuthRoot> {

  final _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.blueAccent, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      BlocProvider(
          create: (context) => RealEstateBloc()..add(RealEstateInitEvent()),
      child: RealEstatePage(),),
      BlocProvider(
        create: (context) => CustomerBloc()..add(CustomerInitEvent()),
        child: CustomerPage(),),
      BlocProvider(
        create: (context) => CalendarBloc()..add(CalendarInitEvent()),
        child: CalendarPage(),),
      BlocProvider(
        create: (context) => SalesmanBloc()..add(SalesmanInitEvent()),
        child: SalesmanPage(),),
      BlocProvider(
        create: (context) => ProfileBloc()..add(ProfileInitEvent()),
        child: ProfilePage(),),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.house_outlined),
        title: ("Ingatlanok"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white60,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_search),
        title: ("Ügyfelek"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white60,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.calendar_month_outlined),
        title: ("Naptár"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white60,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.man),
        title: ("Munkatársak"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white60,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle),
        title: ("Profil"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white60,
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}