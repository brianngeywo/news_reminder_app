import 'package:flutter/material.dart';
import 'package:news_reminder_app/signin.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Insider Space',
      home: SignInPage(),
    );
  }
}
