import 'package:flutter/material.dart';
import 'package:flutter_application_fincet/AgregarCuenta.dart';
import 'package:flutter_application_fincet/BalanceGeneral.dart';
import 'package:flutter_application_fincet/IngresosPage.dart';
import 'package:flutter_application_fincet/gastosForm.dart';
import 'package:flutter_application_fincet/misCuentas.dart';

class NavBar extends StatefulWidget {
  final Function currentIndex;
  const NavBar({super.key, required this.currentIndex});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;

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
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => Container(
                      color: const Color.fromARGB(255, 46, 46, 46),
                      child: Wrap(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      // texto de balance gastos
                                      "Agregar",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                            ),
                            Divider(
                              // barrita blanca que separa
                              color: Colors.white,
                              thickness: 3,
                              indent: 33,
                              endIndent: 33,
                              height: 40,
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 80,
                                    child: FloatingActionButton.extended(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      label: Text('Ingresos',
                                          style: TextStyle(fontSize: 25)),
                                      // <-- Text
                                      backgroundColor: Colors.black,
                                      icon: Icon(
                                        // <-- Icon
                                        Icons.monetization_on_outlined,
                                        size: 24.0,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const IngresosPage(),
                                            ));
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                    child: FloatingActionButton.extended(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      label: Text('Gastos',
                                          style: TextStyle(fontSize: 25)),
                                      // <-- Text
                                      backgroundColor: Colors.black,
                                      icon: Icon(
                                        // <-- Icon
                                        Icons.money_off,
                                        size: 24.0,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const gastosForm(),
                                            ));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 15, bottom: 25, left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 80,
                                      child: FloatingActionButton.extended(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        label: Text('Cuentas',
                                            style: TextStyle(fontSize: 25)),
                                        // <-- Text
                                        backgroundColor: Colors.black,
                                        icon: Icon(
                                          // <-- Icon
                                          Icons.account_balance_wallet_outlined,
                                          size: 24.0,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const AgregarCuenta(),
                                              ));
                                        },
                                      ),
                                    )
                                  ],
                                ))
                          ]),
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
