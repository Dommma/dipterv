import 'package:dipterv/bloc/authentication/auth_cubit.dart';
import 'package:dipterv/ui/pages/calendar_page.dart';
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
              Image.network(
                "https://nextgenerationtechnologies.in/uploads/page/37/flutter_logo.png",
                fit: BoxFit.contain,
                height: 40,
              ),
            ],
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
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
              print("Name: ${state.emailText}, PW: ${state.passwordText}");
              return Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    initialValue: state.emailText,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    cursorColor: CustomColor.mainColor,
                    onChanged: (text) {
                      context.read<AuthCubit>().changeUserText(text);
                    },
                    decoration: const InputDecoration(
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
                    initialValue: state.passwordText,
                    textInputAction: TextInputAction.done,
                    obscureText: state.isPasswordViewActive,
                    cursorColor: CustomColor.mainColor,
                    onChanged: (text) {
                      context.read<AuthCubit>().changePasswordText(text);
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.lock),
                      ),
                      suffix: IconButton(
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
                      onPressed: (state.passwordText.isEmpty || state.emailText.isEmpty) ? null
                          : () => context.read<AuthCubit>().loginUser(state.emailText, state.passwordText),
                      child: const Text("Login")
                  )
                ],
              ),
            );
            } else {
              return Container();
            }
          },
        )
    );
  }
}
