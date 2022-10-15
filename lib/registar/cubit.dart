import 'package:breking_bad/registar/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit()
      : super(
          RegisterInitState(),
        );

  String? name;
  String? email;
  String? phone;
  String? password;
  final formKey = GlobalKey<FormState>();
  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    emit(RegisterLoadingState());
    try {
      final response =
          await Dio().post('https://student.valuxapps.com/api/register', data: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
      });
      print(response.data);
      if (response.data['status']) {
        emit(RegisterSuccessState());
        {
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString('token', response.data['data']['token']);
        }
      } else {
        emit(RegisterErrorState(
          message: response.data['message'],
        ));
      }
    } catch (e) {
      print(e);

      emit(RegisterErrorState(
        message: e.toString(),
      ));
    }
  }
}
