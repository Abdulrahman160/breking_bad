import 'dart:io';

import 'package:breking_bad/login/view.dart';
import 'package:breking_bad/registar/view.dart';
import 'package:breking_bad/view/home/view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final sp=await SharedPreferences.getInstance();
  HttpOverrides.global = _MyHttpOverrides();
  final isLoading = sp.getString('token') != null;
  runApp(MyApp(
    home: isLoading ? HomeView():RegisterView(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.home}) : super(key: key);
final Widget home;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginView(),
    );
  }
}

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
