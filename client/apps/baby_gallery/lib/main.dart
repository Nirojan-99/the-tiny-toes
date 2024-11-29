import 'package:baby_gallery/screens/login_screen.dart';
import 'package:baby_gallery/screens/users_screen.dart';
import 'package:baby_gallery/services/auth_provider.dart';
import 'package:baby_gallery/theme/custom_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Gallery',
      theme: customDarkTheme(),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      routes: {
        "/login": (context) => const LoginScreen(),
        "/users": (context) => const UsersScreen(),
      },
    );
  }
}
