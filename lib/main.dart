import 'package:flutter/material.dart';
import 'pages/all.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          background: Color.fromRGBO(255, 255, 255, 1),
          surface: Color.fromRGBO(189, 255, 214, 1),
          secondary: Color.fromRGBO(157, 255, 148, 1),
          primary: Color.fromRGBO(81, 221, 49, 1),
          error: Color.fromRGBO(187, 53, 53, 1),
          onBackground: Color.fromRGBO(28, 28, 28, 1),
          onSurface: Color.fromRGBO(36, 36, 36, 1),
          onSecondary: Color.fromRGBO(177, 193, 225, 1),
          onPrimary: Color.fromRGBO(237, 242, 255, 1),
          onError: Color.fromRGBO(255, 207, 207, 1),
        ),
      ),
      home: const Login(title: 'Delivery demo'),
    );
  }
}