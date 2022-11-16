import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_application_fincet/gastos.dart';
import 'package:flutter_application_fincet/widgets/navBar.dart';
import 'package:flutter_application_fincet/widgets/sideMenu.dart';

class VerMasGastos extends StatefulWidget {
  const VerMasGastos({super.key});

  @override
  State<StatefulWidget> createState() => _VerMasGastosState();
}

class _VerMasGastosState extends State<VerMasGastos> {
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
      drawer: sideMenu(),
      bottomNavigationBar: myNavBar,
    );
  }
}

Widget cuerpo(context) {
  return ListView(
    shrinkWrap: true,
    children: [
      Container(
        color: const Color.fromARGB(255, 46, 46, 46),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                ultimosMovimientos(context),
                dia1(context),
                dia2(context),
                dia3(context)
                
               
               
              ],
            ),
          ),
        ),
      ),
    ],
  );
}



Widget ultimosMovimientos(context) {
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        children: const [
          Text(
            // texto de ultimos movimientos
            textAlign: TextAlign.left,
            "Todos los movimientos",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      
      
    ],
  );
}


Widget ultimosMovimientosDisplay(context) {
  final List<String> categoriaGasto = <String>[
    'Comida',
    'Mascota',
    'Comida',
    
  ];
  final List<String> cuenta = <String>[
    "Banco Santander",
    "Efectivo",
    "Efectivo",
    
  ];
  final List<String> valor = <String>[
    "-30.000 CLP",
    "-7.000 CLP",
    "-3.000 CLP",
  ];

  return ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    
    itemCount: categoriaGasto.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        //Caja ultimos movimientos
        color: const Color.fromARGB(255, 96, 95, 95),
        borderOnForeground: true,
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(15), left: Radius.zero)),
        margin: const EdgeInsets.all(6),
        child: InkWell(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListTile(
            // Icono de ultimos movimientos
            leading: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 10),
                  child: Icon(Icons.remove_circle_rounded),
                )
              ],
            ),
            title: Column(
              // Categoria del gasto
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(categoriaGasto[index],
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                )
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Gasto
                Text(valor[index],
                    style: const TextStyle(fontSize: 12, color: Colors.white)),
                Row(
                  children: [
                    // Cuenta del gasto
                    Text(cuenta[index],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ],
                )
              ],
            ),
          ),
        ])),
      );
    },
    separatorBuilder: (context, int index) => const Divider(),
  );
}

//
//
//
// Esto es chit para salir del paso despues se borra
//
//
//


Widget dia1(context) {
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        children: const [
          Text(
            // texto de ultimos movimientos
            textAlign: TextAlign.left,
            "lun., 14 de noviembre 2022",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      dia1Display(context)
      
    ],
  );
}

Widget dia1Display(context) {
  final List<String> categoriaGasto = <String>[
    'Ropa',
    'Comida',
    'Regalo',
    
  ];
  final List<String> cuenta = <String>[
    "Banco Santander",
    "Efectivo",
    "Efectivo",
    
  ];
  final List<String> valor = <String>[
    "-20.000 CLP",
    "-5.000 CLP",
    "-33.000 CLP",
  ];

  return ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    
    itemCount: categoriaGasto.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        //Caja ultimos movimientos
        color: const Color.fromARGB(255, 96, 95, 95),
        borderOnForeground: true,
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(15), left: Radius.zero)),
        margin: const EdgeInsets.all(6),
        child: InkWell(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListTile(
            // Icono de ultimos movimientos
            leading: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 10),
                  child: Icon(Icons.remove_circle_rounded),
                )
              ],
            ),
            title: Column(
              // Categoria del gasto
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child:  Text(categoriaGasto[index],
                  
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                )
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Gasto
                Text(valor[index],
                    style: const TextStyle(fontSize: 12, color: Colors.white)),
                Row(
                  children: [
                    // Cuenta del gasto
                    Text(cuenta[index],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ],
                )
              ],
            ),
          ),
        ])),
      );
    },
    separatorBuilder: (context, int index) => const Divider(),
  );
}


Widget dia2(context) {
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        children: const [
          Text(
            // texto de ultimos movimientos
            textAlign: TextAlign.left,
            "viernes., 11 de noviembre 2022",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      dia2Display(context)
      
    ],
  );
}

Widget dia2Display(context) {
  final List<String> categoriaGasto = <String>[
    'Comida',
    'Ropa',
    'Mascota',
    
  ];
  final List<String> cuenta = <String>[
    "Banco Santander",
    "Efectivo",
    "Efectivo",
    
  ];
  final List<String> valor = <String>[
    "-7.000 CLP",
    "-4.000 CLP",
    "-10.000 CLP",
  ];

  return ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    
    itemCount: categoriaGasto.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        //Caja ultimos movimientos
        color: const Color.fromARGB(255, 96, 95, 95),
        borderOnForeground: true,
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(15), left: Radius.zero)),
        margin: const EdgeInsets.all(6),
        child: InkWell(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListTile(
            // Icono de ultimos movimientos
            leading: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 10),
                  child: Icon(Icons.remove_circle_rounded),
                )
              ],
            ),
            title: Column(
              // Categoria del gasto
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child:  Text(categoriaGasto[index],
                  
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                )
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Gasto
                Text(valor[index],
                    style: const TextStyle(fontSize: 12, color: Colors.white)),
                Row(
                  children: [
                    // Cuenta del gasto
                    Text(cuenta[index],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ],
                )
              ],
            ),
          ),
        ])),
      );
    },
    separatorBuilder: (context, int index) => const Divider(),
  );
}


Widget dia3(context) {
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        children: const [
          Text(
            // texto de ultimos movimientos
            textAlign: TextAlign.left,
            "jue., 10 de noviembre 2022",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      dia3Display(context)
      
    ],
  );
}

Widget dia3Display(context) {
  final List<String> categoriaGasto = <String>[
    'Comida',
    'Comida',
    'Comida',
    
  ];
  final List<String> cuenta = <String>[
    "Banco Santander",
    "Efectivo",
    "Efectivo",
    
  ];
  final List<String> valor = <String>[
    "-10.000 CLP",
    "-2.000 CLP",
    "-1.500 CLP",
  ];

  return ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    
    itemCount: categoriaGasto.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        //Caja ultimos movimientos
        color: const Color.fromARGB(255, 96, 95, 95),
        borderOnForeground: true,
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(15), left: Radius.zero)),
        margin: const EdgeInsets.all(6),
        child: InkWell(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListTile(
            // Icono de ultimos movimientos
            leading: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 10),
                  child: Icon(Icons.remove_circle_rounded),
                )
              ],
            ),
            title: Column(
              // Categoria del gasto
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child:  Text(categoriaGasto[index],
                  
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                )
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Gasto
                Text(valor[index],
                    style: const TextStyle(fontSize: 12, color: Colors.white)),
                Row(
                  children: [
                    // Cuenta del gasto
                    Text(cuenta[index],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ],
                )
              ],
            ),
          ),
        ])),
      );
    },
    separatorBuilder: (context, int index) => const Divider(),
  );
}