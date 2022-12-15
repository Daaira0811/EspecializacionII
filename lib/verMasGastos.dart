import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter_application_fincet/widgets/navBar.dart';
import 'package:flutter_application_fincet/widgets/sideMenu.dart';

import 'DAO/DB.dart';
import 'models/Dinero.dart';

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
                FutureBuilder(
                    future: ListaGastos(),
                    builder: (ctx, snapshot) {
                      // Checking if future is resolved
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If we got an error
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: TextStyle(fontSize: 18),
                            ),
                          );

                          // if we got our data
                        } else if (snapshot.hasData) {
                          // Extracting data from snapshot object
                          final List<Dinero> data =
                              snapshot.data as List<Dinero>;
                          return Center(
                              child: (Column(
                            children: [ultimosMovimientos(context, data)],
                          )));
                        }
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),

                //  ultimosMovimientos(context),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

ListaGastos() async {
  List<Dinero> list = await DB.listarDinero();
  //Cuenta a=list[0];
  list.forEach((element) {
    print(element.monto);
  });
  return list.toList();
}

Widget ultimosMovimientos(context, List<Dinero> data) {
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
            "Ultimos movimientos",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      ultimosMovimientosDisplay(context, data)
    ],
  );
}

Widget ultimosMovimientosDisplay(context, List<Dinero> data) {
  final List<String> cuenta = <String>[
    "Banco Santander",
    "Efectivo",
    "Banco Santander",
    "Efectivo",
    "Banco Santander",
    "Banco Santander",
    "Efectivo",
    "Banco Santander",
    "Efectivo",
    "Banco Santander",
    "Banco Santander",
    "Efectivo",
    "Banco Santander",
    "Efectivo",
    "Banco Santander",
  ];

  List<Dinero> reverseData = data.reversed.toList();

  return ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    itemCount: data.length - 1,
    reverse: true,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        //Caja ultimos movimientos
        color: const Color.fromARGB(255, 96, 95, 95),
        borderOnForeground: true,
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(15), left: Radius.zero)),
        margin: const EdgeInsets.all(10),
        child: InkWell(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListTile(
            // Icono de ultimos movimientos
            leading: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 10),
                  child: Icon(Icons.add_circle_rounded),
                )
              ],
            ),
            title: Column(
              // Categoria del gasto
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(reverseData[index].asunto.toString(),
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
                Text("- " + reverseData[index].monto.toString(),
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
