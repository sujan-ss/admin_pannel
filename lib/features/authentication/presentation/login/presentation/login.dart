import 'package:admin_panel/features/authentication/presentation/login/bloc/login_bloc.dart';
import 'package:admin_panel/features/verification/presentation/verification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    //check debug mode
    if (kDebugMode) {
      emailController.text = "riteshlama5@gmail.com";
      passwordController.text = "Hetauda@55";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const Dialog(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Center(child: CircularProgressIndicator()));
              },
            );
          } else {
            Navigator.of(context).pop();
            if (state is LoginFailure) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Login Failed"),
                    content: Text(state.message),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            } else if (state is LoginSuccess) {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const VerificationPage();
                },
              ));
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                const Spacer(),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ]),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  maximumSize: Size(400, 100)),
                              onPressed: () {
                                context.read<LoginBloc>().add(FormSubmitEvent(
                                    email: emailController.text,
                                    password: passwordController.text));
                              },
                              child: const Text('Login'),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
