import 'package:dipterv/bloc/authentication/auth_cubit.dart';
import 'package:dipterv/ui/pages/calendar/calendar_page.dart';
import 'package:flutter/material.dart';
import '../styles/custom_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Dipterv")
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<AuthCubit, AuthState>(
            listenWhen: (_, state) => state is !AuthInitialState,
            listener: (context, state) {
              if(state is AuthLoadingState) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  },
                );
              }
              if(state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
              if(state is AuthLoggedInState) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => CalendarPage()), (route) => false);
              }
            },
            buildWhen: (_, state) => state is AuthInitialState,
            builder: (context, state) {
              if(Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              if(state is AuthInitialState) {
                return Padding(
                padding: const EdgeInsets.only(left:30, right: 30, top: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:80.0, right: 80.0, bottom: 30),
                      child: Image.network("https://user-images.githubusercontent.com/51419598/152648731-567997ec-ac1c-4a9c-a816-a1fb1882abbe.png"),
                    ),
                    TextFormField(
                      controller: state.emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      cursorColor: CustomColor.mainColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        hintText: "Email or username",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: state.passwordController,
                      textInputAction: TextInputAction.done,
                      obscureText: state.isPasswordViewActive,
                      cursorColor: CustomColor.mainColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        hintText: "Password",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(Icons.lock),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<AuthCubit>().changePasswordView();
                          },
                          icon: Icon(state.isPasswordViewActive ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        )),
                      ),
                        onPressed: () => context.read<AuthCubit>().loginUser(),
                        child: const Text("Login", style: TextStyle(fontSize: 20),)
                    ),
                  ],
                ),
              );
              } else {
                return Container();
              }
            },
          ),
        )
    );
  }
}
