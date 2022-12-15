import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_application_fincet/balanceIngresos.dart';
import 'package:flutter_application_fincet/widgets/navBar.dart';
import 'package:flutter_application_fincet/widgets/sideMenu.dart';

import 'DAO/DB.dart';
import 'models/Cuenta.dart';
import 'models/Dinero.dart';

class VerMasIngresos extends StatefulWidget {
  const VerMasIngresos({super.key});

  @override
  State<StatefulWidget> createState() => _VerMasIngresosState();
}

class _VerMasIngresosState extends State<VerMasIngresos> {
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
      backgroundColor: const Color.fromARGB(255, 46, 46, 46),
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
                    future: listaIngresos(),
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
                            children: [
                              FutureBuilder(
                                  future: ListaCuentas(),
                                  builder: (ctx, snapshot) {
                                    // Checking if future is resolved
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
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
                                        final List<Cuenta> dataCuentas =
                                            snapshot.data as List<Cuenta>;
                                        return Center(
                                            child: (Column(
                                          children: [
                                            //  ultimosMovimientos(context, data, cuentas)
                                            ultimosMovimientos(
                                                context, data, dataCuentas)
                                          ],
                                        )));
                                      }
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  })
                              //  ultimosMovimientos(context, data, cuentas)
                              // ultimosMovimientos(context, data)
                            ],
                          )));
                        }
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),                
                
               
               
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
ListaCuentas() async {
  List<Cuenta> list = await DB.listarCuentas();
  //Cuenta a=list[0];
  list.forEach((element) {
    print(element.saldo);
  });
  return list.toList();
}


Widget ultimosMovimientos(context, List<Dinero> data, List<Cuenta> dataCuentas) {
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
      
 ultimosMovimientosDisplay(context, data, dataCuentas)

    ],
  );
}

String buscarCuenta(List<Cuenta> dataCuentas, int index) {
  String nombreCuenta = '';
  for (Cuenta i in dataCuentas)
    if (index == int.parse(i.id.toString())) {
      return nombreCuenta = i.nombreCuenta.toString();
    };
  return nombreCuenta;
}

Widget ultimosMovimientosDisplay(context,List<Dinero> data, List<Cuenta> dataCuentas) {
    List<Dinero> reverseData = data.reversed.toList();

  return ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    
    itemCount: data.length,
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
                  child: Icon(Icons.add_circle_rounded),
                )
              ],
            ),
            title: Column(
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
                Text("+ " + reverseData[index].monto.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.white)),
                Row(
                  children: [
                    // Cuenta del gasto
                    Text(buscarCuenta(dataCuentas, int.parse(reverseData[index].idCuenta.toString())),
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


