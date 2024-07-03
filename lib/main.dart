import 'package:flutter/material.dart';
import 'package:personalfinanceapp/constants/colors.dart';
import 'package:personalfinanceapp/screens/login_page.dart';
import 'package:personalfinanceapp/screens/register_page.dart';
import 'package:personalfinanceapp/screens/splash_page.dart';

void main(){

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldColor,
        textTheme: TextTheme(displaySmall: TextStyle(color: Colors.white,fontSize: 16))
      ),
      initialRoute: '/',
      routes: {
        '/':(context)=>const SplashPage(),
        'login':(context)=> const LoginPage(),
        '/register':(context)=> const RegisterPage()
      },
    );
  }
}
