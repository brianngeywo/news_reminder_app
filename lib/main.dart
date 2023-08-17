import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_reminder_app/homepage.dart';
import 'package:news_reminder_app/package_model.dart';
import 'package:news_reminder_app/scraper_service.dart';

import 'firebase_options.dart';
import 'http_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Insider Space',
      home: const MyHomePage(title: 'Insider Space'),
    );
  }
}
