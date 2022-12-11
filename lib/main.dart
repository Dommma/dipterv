import 'package:dipterv/bloc/authentication/auth_cubit.dart';
import 'package:dipterv/bloc/calendar/calendar_cubit.dart';
import 'package:dipterv/bloc/event/event_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit(),),
        BlocProvider<CalendarCubit>(create: (context) => CalendarCubit(),),
        BlocProvider<EventCubit>(create: (context) => EventCubit(),)
      ],
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
