import 'package:baby_gallery/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _paddingTop = 200;
  double _opacity = 0.2;
  final int _duration = 1;

  @override
  void initState() {
    super.initState();

    // Animate the padding and opacity
    Future.delayed(const Duration(seconds: 0)).then((_) {
      setState(() {
        _paddingTop = 0;
        _opacity = 1;
      });
    });

    // Navigate after checking login status
    Future.delayed(const Duration(seconds: 1)).then((_) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      bool status = await authProvider.checkLoginStatus();
      if (status) {
        Navigator.pushReplacementNamed(context, '/users');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).splashColor,
        child: Center(
          child: AnimatedContainer(
            duration: Duration(seconds: _duration),
            curve: Curves.fastOutSlowIn,
            padding: EdgeInsets.only(top: _paddingTop),
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: width * .2),
            child: AnimatedOpacity(
              opacity: _opacity,
              curve: Curves.fastOutSlowIn,
              duration: Duration(seconds: _duration),
              child: const Text(
                "BABY GALLERY",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}