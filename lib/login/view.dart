import 'package:breking_bad/login/cubit.dart';
import 'package:breking_bad/login/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../registar/view.dart';
import '../view/home/view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: BlocListener<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessesState) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeView(),
                ),
              );
            } else if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Builder(builder: (context) {
              final cubit = BlocProvider.of<LoginCubit>(context);
              return Form(
                key: cubit.formKey,
                child: ListView(children: [
                  const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.blue),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (v) => cubit.email = v,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        counterStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Email can not be empty!';
                        } else if (!v.contains('@')) {
                          return 'Email must be contains @';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        onSaved: (v) => cubit.password = v,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          counterStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Password can not be empty!';
                          } else if (v.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        }),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => RegisterView(),
                          ),
                        );
                      },
                      child: Text('Create new email?'),
                    ),
                  ),
                  BlocBuilder<LoginCubit, LoginStates>(
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return Center(child: CupertinoActivityIndicator());
                      }

                      return ElevatedButton(
                        onPressed: cubit.login, // دي او دي عشان تشتغل مينفعش اللي كنت عامله
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ]),
              );
            }),
          ),
        ),
      ),
    );
  }
}
