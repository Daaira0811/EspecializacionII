import 'package:flutter/material.dart';
import 'package:flutter_application_fincet/AgregarCuenta.dart';
import 'package:flutter_application_fincet/BalanceGeneral.dart';
import 'package:flutter_application_fincet/IngresosPage.dart';
import 'package:flutter_application_fincet/misCuentas.dart';

class NavBar extends StatefulWidget {
  final Function currentIndex;
  const NavBar({super.key, required this.currentIndex});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;
  final screens = [
    BalanceGeneral(),
    IngresosPage(),
    mostrarCuentas(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: index,
        onTap: (int i) {
          if (i == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BalanceGeneral(),
                ));
          } else if (i == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AgregarCuenta(),
                ));
          } else if (i == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const mostrarCuentas(),
                ));
          }
          // setState(() {
          //   index = i;
          //   widget.currentIndex(i);
          // });
        },
        selectedItemColor: Color.fromARGB(218, 0, 106, 211),
        iconSize: 25,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        items: const [
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
        ]);
  }
}
