import 'package:dipterv/ui/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarWidget(),
      appBar: AppBar(),
      body: Container()
    );
  }

}