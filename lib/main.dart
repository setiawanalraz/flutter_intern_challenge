import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intern_flutter_challenge/pages/login_page.dart';
import 'package:intern_flutter_challenge/widgets/my_will_pop_scope.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showMainPage = prefs.getBool("showMainPage") ?? false;

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // add this custom error when show maps
            Text("Something went wrong, please wait"),
            SizedBox(height: 10),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  };

  runApp(MyApp(showMainPage: showMainPage));
}

class MyApp extends StatelessWidget {
  final bool showMainPage;
  const MyApp({
    Key? key,
    required this.showMainPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Intern Flutter Challenge",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.light,
          primary: Colors.blue,
          secondary: Colors.teal,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontFamily: 'Oswald',
            fontSize: 45.0,
            color: Colors.amber,
          ),
        ),
      ),
      home: showMainPage ? const MyWillPopScope() : const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
