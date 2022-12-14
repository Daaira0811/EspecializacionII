import 'package:flutter/material.dart';
import 'package:flutter_application_fincet/DAO/DB.dart';
import 'package:flutter_application_fincet/login.dart';
import 'package:flutter_application_fincet/misCuentas.dart';
import 'package:flutter_application_fincet/models/Cuenta.dart';
import 'package:flutter_application_fincet/widgets/navBar.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AgregarCuenta extends StatefulWidget {
  const AgregarCuenta({super.key});

  @override
  State<AgregarCuenta> createState() => _AgregarCuentaState();
}



class Data {
  String nombreCuenta = "Nombre1";
  String divisa = 'Divisa1';
  double saldo = 0.1;

  Data({required this.nombreCuenta, required this.divisa, required this.saldo});
}

class _AgregarCuentaState extends State<AgregarCuenta> {

  final nombreController = TextEditingController();
  final saldoController = TextEditingController();
  late DB db = DB.instance;
  late Cuenta _cuenta;



  final formKey = GlobalKey<FormState>();
  Color pickerColor = const Color(0xff2196f3);
  Color currentColor = const Color(0xff2196f3);
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
  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  //  changeData(nombreCuenta, divisa, saldo) {
  //   final data = Data(nombreCuenta: nombreCuenta, divisa: divisa, saldo: saldo);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 96, 95, 95),
        // ignore: prefer_const_constructors
        title: Text(
          "FINCET",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: cuerpo(context),
      bottomNavigationBar: myNavBar,
    );
  }

  Widget cuerpo(context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          color: const Color.fromARGB(255, 46, 46, 46),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [titulo(context), formulario(context)],
            ),
          ),
        )
      ],
    );
  }

  Widget titulo(context) {
    return Column(children: const <Widget>[
      Text(
        // texto de balance gastos
        "Agregar Cuenta",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      Divider(
        // barrita blanca que separa
        color: Colors.white,
        thickness: 3,
      ),
      SizedBox(
        height: 10,
      ), // da espacio entre barrita y balance
    ]);
  }

  Widget formulario(context) {
    String? nombreCuenta;
    double? saldo;

    List<String> monedas = [
      'Peso Chileno (CLP)',
      'Dólar estaunidense (USD)',
      'EURO (EUR)',
      'Libra esterlina (GBP)',
    ];
    String? selectedItem = 'Peso Chileno (CLP)';

    Future pickColor(context) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text('Elige un color'),
              content: SingleChildScrollView(
                  child: BlockPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
              )),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Seleccionar',
                  ),
                )
              ]),
        );
    return Container(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  "Nombre de la cuenta:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
            TextFormField(
              controller: nombreController,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  )
                  //labelText: 'Nombre de la cuenta',
                  ),
              // onSaved: (value) {
              //   nombreCuenta = value;
              // },
              // validator: (value) {
              //   if (value.isEmpty) {
              //    return "Ingrese nombre de la cuenta";
              //  }
              //  },
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 12, top: 30),
                child: Text(
                  "Divisa:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  )),
              value: selectedItem,
              items: monedas
                  .map((moneda) => DropdownMenuItem(
                      value: moneda,
                      child: Text(
                        moneda,
                        style: TextStyle(fontSize: 20),
                      )))
                  .toList(),
              onChanged: (moneda) => selectedItem = moneda,
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 12, top: 30),
                child: Text(
                  "Saldo de la cuenta:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
            TextFormField(
                controller: saldoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    suffixText: 'CLP',

                    // enabledBorder:
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    )),
                onSaved: (value) {
                  saldo = double.tryParse(value!);
                }
                /*
          validator: (value) {
            if (value.isEmpty) {
              return "Ingrese nombre de la cuenta";
            }
          }, */
                ),
            const Padding(
                padding: EdgeInsets.only(bottom: 12, top: 30),
                child: Text(
                  "Color:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
            Row(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: pickerColor,
                      onPrimary: Colors.black,
                      shape: CircleBorder(),
                    ),
                    onPressed: () => pickColor(context),
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 41,
                    )),
                SizedBox(
                  width: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.shade800,
                  ),
                  width: 40,
                  height: 40,
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange.shade900,
                  ),
                  width: 40,
                  height: 40,
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.lightBlue,
                  ),
                  width: 40,
                  height: 40,
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.shade900,
                  ),
                  width: 40,
                  height: 40,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  child: const Text("Guardar cuenta"),
                  onPressed: () {
                    // if (nombreCuenta != null &&
                    //     selectedItem != null &&
                    //     saldo != saldo) {
                    //   // final data = Data(
                    //   //     nombreCuenta: nombreCuenta,
                    //   //     divisa: selectedItem!,
                    //   //     saldo: saldo!);
                      int saldo = int.parse(saldoController.text);
                      _cuenta = Cuenta ( id:null, nombreCuenta: nombreController.text, saldo:saldo, moneda:selectedItem, color: null);
                      db.insertCuenta(_cuenta);

                    //changeData(nombreCuenta, divisa, saldo)
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const mostrarCuentas(),
                          //misCuentas(data: Data(nombreCuenta: nombreCuenta!, divisa: selectedItem!, saldo: saldo!
                        ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
