import 'package:breking_bad/registar/cubit.dart';
import 'package:breking_bad/registar/states.dart';
import 'package:breking_bad/view/home/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('REGISTAR'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocListener<RegisterCubit, RegisterStates>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomeView(),
                  ),
                );
              } else if (state is RegisterErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            child: Builder(builder: (context) {
              final cubit = BlocProvider.of<RegisterCubit>(context);
              return Form(
                key: cubit.formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      onSaved: (v) => cubit.name = v,
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Name can not be empty!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (v) => cubit.email = v,
                      decoration: InputDecoration(
                        hintText: 'Email',
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
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (v) => cubit.phone = v,
                      decoration: InputDecoration(
                        hintText: 'Phone',
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Phone can not be empty!';
                        } else if (!v.startsWith('+201')) {
                          return 'Phone must start with +201';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (v) => cubit.password = v,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Password can not be empty!';
                        } else if (v.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<RegisterCubit, RegisterStates>(
                      builder: (context, state) {
                        if (state is RegisterLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                          onPressed: cubit.register,
                          child: Text('Registar'),
                        );
                      },
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
