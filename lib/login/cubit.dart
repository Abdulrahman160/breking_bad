import 'package:breking_bad/login/state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit():super(LoginInitState());
  String? email;
  String? password;
  final formKey =GlobalKey<FormState>();
  Future<void> login() async{
    if(!formKey.currentState!.validate()){
      return ;
    }
    formKey.currentState!.save();
    emit(LoginLoadingState());
    try{
      final response =await Dio().post(
          'https://student.valuxapps.com/api/login',

          data: {
            "email":email,
            "password":password,
          }
      );
      if(response.data['status']){
        emit(LoginSuccessesState());
        {
          SharedPreferences sp=await SharedPreferences.getInstance();
          sp.setString('token',response.data['data']['token'] );

        }
      }
      else{
        emit(LoginErrorState(
          message: response.data['message'],
        ));
      }
    }
    catch(e){

      emit(LoginErrorState(
        message:e.toString(),
      ));

    }
  }

}

