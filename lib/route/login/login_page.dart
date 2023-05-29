import 'package:dipterv/route/login/login_bloc.dart';
import 'package:dipterv/route/root/auth_root.dart';
import 'package:dipterv/style/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _passwordVisible = true;
  var _emailIsValid = true;
  var _passwordIsValid = true;

  LoginBloc get _bloc => context.read<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if(state is LoginLoadState) {
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
              if(state is LoginBasicState) {
                if(state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
                }
              }
              if(state is LoginSuccessState) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => AuthRoot()), (route) => false);
              }
            },
            buildWhen: (_, state) => state is LoginBasicState,
            builder: (context, state) {
              if(Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              if(state is LoginBasicState) {
                return Padding(
                padding: const EdgeInsets.only(left:30, right: 30, top: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:80.0, right: 80.0, bottom: 30),
                      child: Image.asset('assets/logo.png'),
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      cursorColor: CustomColor.mainColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        hintText: "Email",
                        errorText: _emailIsValid ? null : "Ne hagyja üresen a mezőt!",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      obscureText: _passwordVisible,
                      cursorColor: CustomColor.mainColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        hintText: "Jelszó",
                        errorText: _passwordIsValid ? null : "Ne hagyja üresen a mezőt!",
                        prefixIcon: const Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(Icons.lock),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
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
                        onPressed: () => _loginButtonPressed(),
                        child: const Text("Bejelentkezés", style: TextStyle(fontSize: 20),)
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

  void _loginButtonPressed() {
    setState(() {
      _emailIsValid = _emailController.text.isNotEmpty;
      _passwordIsValid = _passwordController.text.isNotEmpty;
    });
    if(_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }
    _bloc.add(LoginPressedEvent(userName: _emailController.text, password: _passwordController.text));
    _passwordController.text = "";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
