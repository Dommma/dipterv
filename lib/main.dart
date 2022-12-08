import 'package:dipterv/bloc/authentication/auth_cubit.dart';
import 'package:dipterv/ui/pages/login_page.dart';
import 'package:dipterv/ui/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dipterv',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginPage()),
    );
  }
}
