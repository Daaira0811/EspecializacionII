import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter_application_fincet/verMasIngresos.dart';
import 'package:flutter_application_fincet/widgets/navBar.dart';
import 'package:flutter_application_fincet/widgets/sideMenu.dart';
import 'package:flutter_application_fincet/DAO/DB.dart';
import 'models/Chart.dart';
import 'models/Cuenta.dart';
import 'models/Dinero.dart';

class BalanceIngresos extends StatefulWidget {
  const BalanceIngresos({super.key});

  @override
  State<BalanceIngresos> createState() => _BalanceIngresos ();
}

class _BalanceIngresos extends State<BalanceIngresos> {
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
      drawer: sideMenu(),
      bottomNavigationBar: myNavBar,
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
listaIngresos() async{
  List <Dinero> list = await DB.listarIngresos();

  return list.toList();

}

Widget balanceGastos(context, List<Dinero> data) {
  return Container(
    child:Column(

      children: [
        const Text(
          // texto de balance gastos
          "Balance ingresos",
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
        cajaIngreso(context,data)

      ],
    )
  );


}
Widget cajaIngreso(context, List<Dinero> data){
  int balance = 0;

  data.forEach((element) { balance += element.monto!; });

return TextField(
    // Caja blanca con balance
    enabled: false,

    textAlign: TextAlign.center,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(30),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      hintStyle: const TextStyle(color: Colors.black, fontSize: 30),
      hintText: "$balance" + " CLP",
      fillColor: const Color.fromARGB(255, 217, 217, 217),
      filled: true,
    ),
  );
}

Widget ultimosMovimientos(context, List <Dinero> data, List<Cuenta> dataCuentas) {
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
      /*
      TextField(
          // Caja blanca con balance
      enabled: false,

      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintStyle: const TextStyle(color: Colors.black, fontSize: 10),
        hintText: "- 23.000 CLP",
        fillColor: const Color.fromARGB(255, 217, 217, 217),
        filled: true,
      ),
      )
      */
      ultimosMovimientosDisplay(context,data,dataCuentas)
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

Widget ultimosMovimientosDisplay(context, List<Dinero> data,List<Cuenta> dataCuentas) {
  
  
  
  
  final List<String> cuenta = <String>[
    "Banco Santander",
    "Efectivo",
    "Efectivo",
  ];

  List<Dinero> reverso = data.reversed.toList();

  return ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    itemCount: 3,
    itemBuilder: (BuildContext context, int index) {
      return Card( //Caja ultimos movimientos
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
                  child: Text(reverso[index].asunto.toString(),
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
                Text(reverso[index].monto.toString() + " CLP",
                    style: const TextStyle(fontSize: 12, color: Colors.white)),
                Row(
                  children: [
                    // Cuenta del gasto
                    Text(buscarCuenta(dataCuentas, int.parse(reverso[index].idCuenta.toString())),
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
              builder: (context) => VerMasIngresos(),
            ));
      }, // aqui deberia redirigir al balance general
      child: Text(
        "Ver mas",
        style: TextStyle(fontSize: 15),
      ));
}

Widget graficosTexto(context){
   return  Row(
          children: const [
            Text(
              // texto de ultimos movimientos
              textAlign: TextAlign.left,
              "Graficos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],);
}


Widget grafico(context) {

  List<Chart> data = [
    Chart(15000, "1", charts.ColorUtil.fromDartColor(Colors.green)),
   
    Chart(25000, "3", charts.ColorUtil.fromDartColor(Colors.green)),
    Chart(10000, "5", charts.ColorUtil.fromDartColor(Colors.green)),
  ];
  
  List<charts.Series<Chart, String>> series = [
    charts.Series(
        id: "Gastos",
        data: data,
        domainFn: (Chart, index) => Chart.dias,
        measureFn: (Chart, index) => Chart.dinero,
        colorFn: (Chart, index) => Chart.barColor)
  ];
  return charts.BarChart(
    series,
    animate: true,
  );
}
