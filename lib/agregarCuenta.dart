import 'package:flutter/material.dart';
import 'package:flutter_application_fincet/login.dart';

class AgregarCuenta extends StatefulWidget {
  const AgregarCuenta({super.key});

  @override
  State<AgregarCuenta> createState() => _AgregarCuentaState();
}

class _AgregarCuentaState extends State<AgregarCuenta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 96, 95, 95),
        title: Text(
          "FINCET",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: cuerpo(context),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: 'Agregar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Cuenta',
        ),
      ]),
    );
  }
}

Widget cuerpo(context) {
  return Container(
    color: Color.fromARGB(255, 46, 46, 46),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [titulo(context)],
      ),
    ),
  );
}

Widget titulo(context) {
  return Container(
      child: Column(children: <Widget>[
    const Text(
      // texto de balance gastos
      "Agregar Cuenta",
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    Divider(
      // barrita blanca que separa
      color: Colors.white,
      thickness: 3,
    ),
    SizedBox(
      height: 10,
    ), // da espacio entre barrita y balance
  ]));
}
