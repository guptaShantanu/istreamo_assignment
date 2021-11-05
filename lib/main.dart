import 'package:flutter/material.dart';
import 'package:istreamodemo/feature/splash/ui/splash_screen.dart';

void main() {
  runApp(const IStreamoDemo());
}


class IStreamoDemo extends StatelessWidget {
  const IStreamoDemo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  SplashScreen(),
    );
  }
}