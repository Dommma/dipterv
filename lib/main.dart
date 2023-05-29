import 'package:dipterv/core/locator.dart';
import 'package:dipterv/route/login/login_bloc.dart';
import 'package:dipterv/route/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await loadEnvironment();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dipterv',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocProvider(
    create: (context) => LoginBloc()..add(LoginInitEvent()),
    child: LoginPage()),
    );
  }

}

Future<void> loadEnvironment() async {
  await dotenv.load(fileName: ".env");
}
