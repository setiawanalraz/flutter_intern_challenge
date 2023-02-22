import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Intern Flutter Challenge",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.light,
          primary: Colors.blue,
          secondary: Colors.teal,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontFamily: 'Oswald',
            fontSize: 45.0,
            color: Colors.amber,
          ),
        ),
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
