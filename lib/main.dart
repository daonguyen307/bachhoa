import 'package:doan_tn/pages/auth/login_page.dart';
import 'package:doan_tn/provider/cart_provider.dart';
import 'package:doan_tn/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => FavoriteProvider()),
    ],
    child:  MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt banner "DEBUG"
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoginPage(),
    ),
  );
}
