import 'package:contatosapp/pages/home_page.dart';
import 'package:flutter/material.dart';

class ContatosApp extends StatelessWidget {
  const ContatosApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
