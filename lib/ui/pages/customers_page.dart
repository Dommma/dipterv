import 'package:dipterv/ui/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

class CustomersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarWidget(currentPage: "Customers",),
      appBar: AppBar(
        title: const Text("Customers"),
      ),
      body: Container(),
    );
  }
}