// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_fincet/login.dart';

class BalanceGastos extends StatelessWidget {
  const BalanceGastos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 96, 95, 95),
        title: const Text(
          "FINCET",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: cuerpo(context),
    );
  }
}

Widget cuerpo(context) {
  return Container(
    color: const Color.fromARGB(255, 46, 46, 46),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [balanceGastos(context), ultimosMovimientos(context)],
        ),
      ),
    ),
  );
}

Widget balanceGastos(context) {
  return Container(
      child: Column(
    children: [
      const Text(
        // texto de balance gastos
        "Balance gastos",
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

      TextField(
        // Caja blanca con balance
        enabled: false,

        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(40),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintStyle: TextStyle(color: Colors.black, fontSize: 30),
          hintText: "- 23.000 CLP",
          fillColor: Color.fromARGB(255, 217, 217, 217),
          filled: true,
        ),
      ),
    ],
  ));
}

Widget ultimosMovimientos(context) {
  return Container(
    child: Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Text(
              // texto de ultimos movimientos
              textAlign: TextAlign.left,
              "Ultimos movimientos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        TextField(
            // Caja blanca con balance
        enabled: false,

        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintStyle: TextStyle(color: Colors.black, fontSize: 10),
          hintText: "- 23.000 CLP",
          fillColor: Color.fromARGB(255, 217, 217, 217),
          filled: true,
        ),
        )
      ],
    ),
  );
}
