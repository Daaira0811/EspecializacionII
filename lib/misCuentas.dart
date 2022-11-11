import 'package:flutter/material.dart';
import 'package:flutter_application_fincet/login.dart';
import 'package:flutter_application_fincet/widgets/navBar.dart';

class mostrarCuentas extends StatefulWidget {
  //final Data data;
  //const mostrarCuentas({super.key, required this.data});
  const mostrarCuentas({super.key});

  @override
  State<mostrarCuentas> createState() => _mostrarCuentasState();
}

class Data {
  String nombreCuenta = "Nombre1";
  String divisa = 'Divisa1';
  double saldo = 0.1;

  Data({required this.nombreCuenta, required this.divisa, required this.saldo});
}

class _mostrarCuentasState extends State<mostrarCuentas> {
  int index = 0;
  NavBar? myNavBar;
  @override
  void initState() {
    myNavBar = NavBar(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });

    super.initState();
  }

  static const List<Widget> _pages = <Widget>[
    Login(),
  ];

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
      bottomNavigationBar: myNavBar,

      // bottomNavigationBar:
      //     BottomNavigationBar(items: const <BottomNavigationBarItem>[
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.home),
      //     label: 'Home',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.add_circle_outline),
      //     label: 'Agregar',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.person),
      //     label: 'Cuenta',
      //   ),
      // ]),
    );
  }
}

Widget cuerpo(context) {
  return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      // shrinkWrap: true,
      //physics: NeverScrollableScrollPhysics(),
      // color: Color.fromARGB(255, 46, 46, 46),
      child: Container(
          color: const Color.fromARGB(255, 46, 46, 46),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              // shrinkWrap: true,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [titulo(context), misCuentas(context)],
            ),
          )));
}

Widget titulo(context) {
  // ignore: prefer_const_literals_to_create_immutables
  return Column(children: <Widget>[
    const Text(
      // texto de balance gastos
      "Mis Cuentas",
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    const Divider(
      // barrita blanca que separa
      color: Colors.white,
      thickness: 3,
    ),
    const SizedBox(
      height: 10,
    ), // da espacio entre barrita y balance
  ]);
}

Widget misCuentas(context) {
  final List<String> banco = <String>[
    'Banco Santander',
    'Banco Estado',
    'Efectivo',
  ];
  final List<String> tipo = <String>[
    "Balance",
    "Balance",
    "Balance",
  ];
  final List<String> valor = <String>[
    "120.000 CLP",
    "48.000 CLP",
    "22.000 CLP",
  ];

  return ListView.separated(
    shrinkWrap: true,
    primary: false,
    padding: const EdgeInsets.all(12),
    itemCount: banco.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        color: Colors.white,
        borderOnForeground: true,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(15),
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {},
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                leading: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30, left: 10),
                      child: Icon(Icons.account_balance_outlined),
                    )
                  ],
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text("${banco[index]}",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text("${tipo[index]}",
                        style: const TextStyle(fontSize: 18)),
                    SizedBox(
                      height: 15,
                    ),
                    Text("${valor[index]}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              )
            ])),
      );
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );

  //AGREGAR BOTÓN DE AGREGAR CUENTAS
}
