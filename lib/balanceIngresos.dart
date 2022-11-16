import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_application_fincet/gastos.dart';
import 'package:flutter_application_fincet/widgets/navBar.dart';

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
  return ListView(
    children: 
      [Container(
        color: const Color.fromARGB(255, 46, 46, 46),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                balanceGastos(context),
                ultimosMovimientos(context),
                graficosTexto(context),
                Container(height: 220, width: 700,child: grafico(context))
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget balanceGastos(context) {
  return Column(
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

  TextField(
    // Caja blanca con balance
    enabled: false,

    textAlign: TextAlign.center,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(30),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      hintStyle: const TextStyle(color: Colors.black, fontSize: 30),
      hintText: "57.000 CLP",
      fillColor: const Color.fromARGB(255, 217, 217, 217),
      filled: true,
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
      ultimosMovimientosDisplay(context)
    ],
  );
}

Widget ultimosMovimientosDisplay(context) {
  final List<String> categoriaGasto = <String>[
    'Trabajo',
    'Regalo',
  ];
  final List<String> cuenta = <String>[
    "Banco Santander",
    "Efectivo",
  ];
  final List<String> valor = <String>[
    "15.000 CLP",
    "25.000 CLP",
  ];

  return ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    itemCount: categoriaGasto.length,
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

  List<Gastos> data = [
    Gastos(15000, "1", charts.ColorUtil.fromDartColor(Colors.green), "Ingreso"),
   
    Gastos(25000, "3", charts.ColorUtil.fromDartColor(Colors.green), "Ingreso"),
    Gastos(10000, "5", charts.ColorUtil.fromDartColor(Colors.green), "Ingreso"),
  ];
  
  List<charts.Series<Gastos, String>> series = [
    charts.Series(
        id: "Gastos",
        data: data,
        domainFn: (Gastos, index) => Gastos.dias,
        measureFn: (Gastos, index) => Gastos.dinero,
        colorFn: (Gastos, index) => Gastos.barColor)
  ];
  return charts.BarChart(
    series,
    animate: true,
  );
}
