import 'package:dipterv/ui/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RealEstatePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarWidget(currentPage: "Real estates",),
      appBar: AppBar(
        title: const Text("Real estates"),
      ),
      body: BlocBuilder<>,
    );
  }
}