import 'package:draw_app/src.dart';
import 'package:flutter/material.dart';

class DrawApp extends StatelessWidget {
  const DrawApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draw Stuff n Things',
      theme: lightTheme,
      home: const DrawingPage(),
    );
  }
}
