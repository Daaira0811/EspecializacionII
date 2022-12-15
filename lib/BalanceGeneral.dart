import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_application_fincet/agregarCuenta.dart';
import 'package:flutter_application_fincet/models/Dinero.dart';
import 'package:flutter_application_fincet/models/ChartTest.dart';
import 'package:flutter_application_fincet/verMasGeneral.dart';
import 'package:flutter_application_fincet/widgets/navBar.dart';
import 'package:flutter_application_fincet/widgets/sideMenu.dart';

import 'DAO/DB.dart';
import 'models/Dinero.dart';

class BalanceGeneral extends StatefulWidget {
  const BalanceGeneral({super.key});

  @override
  State<StatefulWidget> createState() => _BalanceGeneralState();
}

class _BalanceGeneralState extends State<BalanceGeneral> {
  late DB db = DB.instance;

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
                    future: ListaDinero(),
                    builder: (ctx, snapshot) {
                      // Checking if future is resolved+
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
                                balanceGastos(context, data),
                                ultimosMovimientos(context, data),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    botonEntrar(context),
                                  ],
                                ),
                                graficosTexto(context),
                                Container(
                                    height: 220,
                                    width: 700,
                                    child: grafico(context, data))
                              ],
                            )),
                          );
                        }
                       
                      }
                      return Center(
                          child: CircularProgressIndicator(),
                        );
                    }),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     botonEntrar(context),
                //   ],
                // ),
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

ListaDinero() async {
  List<Dinero> list = await DB.listarDinero();
  //Cuenta a=list[0];
  list.forEach((element) {
    print(element.monto);
  });
  return list.toList();
}

Widget balanceGastos(context, List<Dinero> data) {
  int balance = 0;
  data.forEach((element) {
    if (element.tipoOperacion == 'esGasto') {
      balance += int.parse(element.monto.toString()) * -1;
    }else{
      balance += element.monto!;
    }
  });
  return Column(
    children: [
      const Text(
        // texto de balance gastos
        "Balance general",
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

      cajaGeneral(context, balance)
    ],
  );
}

Widget cajaGeneral(context, int data) {
  String balance = data.toString();
  return TextField(
    // Caja blanca con balance
    enabled: false,

    textAlign: TextAlign.center,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(30),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      hintStyle: const TextStyle(color: Colors.black, fontSize: 30),
      hintText: balance+" CLP",
      fillColor: const Color.fromARGB(255, 217, 217, 217),
      filled: true,
    ),
  );
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
      
      ultimosMovimientosDisplay(context,data)
    ],
  );
}

Widget ultimosMovimientosDisplay(context,List<Dinero> data) {

  List<Dinero> reverso = data.reversed.toList();
  
  final List<String> cuenta = <String>[
    "Banco Santander",
    "Efectivo",
  ];
 

  return ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    
    itemCount: 2,  // cantidad de ultimos movimientos
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
                Text(reverso[index].monto.toString(),
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
              builder: (context) => VerMasGeneral(),
            ));
      }, // aqui deberia redirigir al balance general
      child: Text(
        "Ver mas",
        style: TextStyle(fontSize: 15),
      ));
}

Widget graficosTexto(context) {
  return Row(
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
    ],
  );
}

Widget grafico(context, List<Dinero> data1) {


 // DateTime dt = DateTime.parse(data1[0].fechaHora.toString());
 // print(dt.day);
 // List<Dinero> dataGrafico = data1.toList();


 


  final List<ChartTest> data = [
    ChartTest(15000, "1", charts.ColorUtil.fromDartColor(Colors.green)),
    ChartTest(7000, "1", charts.ColorUtil.fromDartColor(Colors.green)),
    ChartTest(20000, "2", charts.ColorUtil.fromDartColor(Colors.red)),
    ChartTest(25000, "3", charts.ColorUtil.fromDartColor(Colors.green)),
    ChartTest(5000, "4", charts.ColorUtil.fromDartColor(Colors.red)),
    ChartTest(10000, "5", charts.ColorUtil.fromDartColor(Colors.green)),
  ];

  List<charts.Series<ChartTest, String>> series = [
    charts.Series(
        id: "Gastos",
        data: data,
        domainFn: (ChartTest, index) => ChartTest.dias,
        measureFn: (ChartTest, index) => ChartTest.dinero,
        colorFn: (ChartTest, index) => ChartTest.barColor)
  ];
  return charts.BarChart(
    series,
    animate: true,
  );
}
