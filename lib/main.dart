
import 'package:flutter/material.dart';
import 'package:flutter_application_fincet/login.dart';
void main() {
  runApp(const Fincet());
}

class Fincet extends StatelessWidget {
  const Fincet({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fincet',
      theme: ThemeData(
       
        
      ),
      home: const Login(),
    );
  }
}


