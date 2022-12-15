import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_application_fincet/DAO/DB.dart';
import 'package:flutter_application_fincet/agregarCuenta.dart';
import 'package:flutter_application_fincet/models/Chart.dart';
import 'package:flutter_application_fincet/models/Dinero.dart';
import 'package:flutter_application_fincet/verMasGastos.dart';
import 'package:flutter_application_fincet/widgets/navBar.dart';
import 'package:flutter_application_fincet/widgets/sideMenu.dart';

import 'models/Cuenta.dart';

class BalanceGastos extends StatefulWidget {
  const BalanceGastos({super.key});

  @override
  State<BalanceGastos> createState() => _BalanceGastos();
}

class _BalanceGastos extends State<BalanceGastos> {
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

  @override
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
      bottomNavigationBar: myNavBar,
      drawer: sideMenu(),
    );
  }
}

Widget cuerpo(context) {
  return ListView(
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
                                            balanceGastos(context, data),
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
                            ],
                          )));
                        }
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    botonEntrar(context),
                  ],
                ),
                // graficosTexto(context),
                // Container(height: 220, width: 700, child: grafico(context))
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

ListaGastos() async {
  List<Dinero> list = await DB.listarGastos();
  //Cuenta a=list[0];
  list.forEach((element) {
    print(element.monto);
  });
  return list.toList();
}

ListaCuentas() async {
  List<Cuenta> list = await DB.listarCuentas();
  //Cuenta a=list[0];
  list.forEach((element) {
    print(element.saldo);
  });
  return list.toList();
}

Widget balanceGastos(context, data) {
  return Column(
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

      const Divider(
        // barrita blanca que separa
        color: Colors.white,
        thickness: 3,
      ),
      const SizedBox(
        height: 10,
      ), // da espacio entre barrita y balance
      cajaGastos(context, data)
    ],
  );
}

Widget cajaGastos(context, List<Dinero> data) {
  int montoTotal = 0;
  for (Dinero i in data as List)
    if (i.tipoOperacion.toString() == "esGasto") {
      montoTotal += int.parse(i.monto.toString());
      print(montoTotal);
    }
  int test = montoTotal;
  String balance = "- "+test.toString() + " CLP";
  return TextField(
    // Caja blanca con balance
    enabled: false,

    textAlign: TextAlign.center,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(30),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      hintStyle: const TextStyle(color: Colors.black, fontSize: 30),
      hintText: balance,
      fillColor: const Color.fromARGB(255, 217, 217, 217),
      filled: true,
    ),
  );
}

Widget ultimosMovimientos(
    context, List<Dinero> data, List<Cuenta> dataCuentas) {
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
      ultimosMovimientosDisplay(context, data, dataCuentas)
    ],
  );
}

String buscarCuenta(List<Cuenta> dataCuentas, int index) {
  String nombreCuenta = '';
  for (Cuenta i in dataCuentas)
    if (index == int.parse(i.id.toString())) {
      return nombreCuenta = i.nombreCuenta.toString();
    }
  ;
  return nombreCuenta;
}

Widget ultimosMovimientosDisplay(
    context, List<Dinero> data, List<Cuenta> dataCuentas) {
  List<Dinero> reverseData = data.reversed.toList();
  if (reverseData.isNotEmpty) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: 2,
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
                      style:
                          const TextStyle(fontSize: 12, color: Colors.white)),
                  Row(
                    children: [
                      // Cuenta del gasto
                      Text(
                          buscarCuenta(
                              dataCuentas,
                              int.parse(
                                  reverseData[index].idCuenta.toString())),
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
    }else{
      return Padding(
        padding: const EdgeInsets.only(top: 10,left: 10),
        child:Text(
            "No hay movimientos",
            style: TextStyle(color: Colors.white)) ,
      );

  }
}

Widget botonEntrar(context) {
  return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        foregroundColor: Colors.black,
        backgroundColor: Color.fromARGB(255, 217, 217, 217),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerMasGastos(),
            ));
      }, // aqui deberia redirigir al balance general
      child: Text(
        "Ver mas",
        style: TextStyle(fontSize: 15),
      ));
}

// Widget graficosTexto(context) {
//   return Row(
//     children: const [
//       Text(
//         // texto de ultimos movimientos
//         textAlign: TextAlign.left,
//         "Graficos",
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 15,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ],
//   );
// }

// Widget grafico(context) {
//   List<ChartTest> data = [
//     ChartTest(20000, "2", charts.ColorUtil.fromDartColor(Colors.red)),
//     ChartTest(5000, "4", charts.ColorUtil.fromDartColor(Colors.red)),
//   ];

//   List<charts.Series<ChartTest, String>> series = [
//     charts.Series(
//         id: "Gastos",
//         data: data,
//         domainFn: (ChartTest, index) => ChartTest.dias,
//         measureFn: (ChartTest, index) => ChartTest.dinero,
//         colorFn: (ChartTest, index) => ChartTest.barColor)
//   ];
//   return charts.BarChart(
//     series,
//     animate: true,
//   );
// }
