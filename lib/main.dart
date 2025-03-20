import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:giua_ky/screen/add_product_screen.dart';
import 'package:giua_ky/screen/edit_product_screen.dart';
import 'package:giua_ky/screen/list_product_screen.dart';
import 'package:giua_ky/screen/login_screen.dart';
import 'package:giua_ky/screen/register_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoginScreen(),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginScreen());
          case '/list':
            return MaterialPageRoute(builder: (context) => ListProductScreen());
          case '/add_product':
            return MaterialPageRoute(builder: (context) => AddProductScreen());
          case '/register':
            return MaterialPageRoute(builder: (context) => RegisterScreen());
          case '/edit_product':
            final id = settings.arguments as String; // Nhận ID từ arguments
            return MaterialPageRoute(
                builder: (context) => EditProductScreen(productId: id));
          default:
            return MaterialPageRoute(
                builder: (context) => LoginScreen()); // Mặc định về Login
        }
      },
    );
  }
}
