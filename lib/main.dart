import 'package:flutter/material.dart';
import 'package:news_reminder_app/homepage.dart';
import 'package:news_reminder_app/package_model.dart';
import 'package:news_reminder_app/scraper_service.dart';

import 'http_service.dart';

void main() {
  runApp(const MyApp());
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
