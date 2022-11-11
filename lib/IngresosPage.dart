import 'package:flutter/material.dart';
import 'package:flutter_application_fincet/BalanceGeneral.dart';
import 'package:flutter_application_fincet/widgets/navBar.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';

class IngresosPage extends StatefulWidget {
  const IngresosPage({super.key});

  @override
  State<IngresosPage> createState() => _IngresosPageState();
}

class _IngresosPageState extends State<IngresosPage> {
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
      bottomNavigationBar: myNavBar,
     );
  }

}

  

Widget cuerpo(context) {
  return ListView(
    shrinkWrap: true,
    children:[
      Container(
      color: const Color.fromARGB(255, 46, 46, 46),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children :[
              header(context),
              divisor(context),
              formMonto(context),
              formCuenta(context),
              campoAsunto(context),
              campoFechaHora(context),
              botonAgregar(context)
              ],
          ),
        ),
      ),
    ),
    ] 
  );
}

Widget header(context){
  return Container(
    child: Row(
     children: const [
      Icon(
         IconData(
          0xf05bc, 
          fontFamily: 'MaterialIcons'
          ),
          color: Colors.white,
          size: (40),
      ),
      Padding(
        padding: EdgeInsets.only(left:50),
        child:Text(
        "Agregar ingresos",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ), 
      )  
      ],
  
  ));
}

Widget divisor(context){
  return Container(
    child: Column(
      children: const [
          Divider(
            // barrita blanca que separa
            color: Colors.white,
            thickness: 3,
          ),
          SizedBox(
            height: 10,
          ), // da espacio entre barrita y balance
      ],
    ),
  );
}
// Alinear +0 como en mockup

Widget formMonto(context){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(255, 217, 217, 217),
    ),
    child: TextFormField(
      style: const TextStyle(fontSize: 35),
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText:"0",
        labelText: '+',
        fillColor: Color.fromARGB(255, 217, 217, 217),
        filled: true,
      ),
    )
  );
}



Widget formCuenta(context){

  String? selectedValue;
  List<String> opciones = [
      'Efectivo',
      'Banco Santander'
    ];

    return Column(
       children:[
        Row(
          children:const[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Cuenta:",
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              )),
          ] 
        ),
        
        DropdownButtonFormField<String>(
          hint: const Text("Selecciona una cuenta"),
              decoration: const InputDecoration(
                  filled: true,
                  fillColor:Color.fromARGB(255, 217, 217, 217),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  )),
              value: selectedValue,
              items: opciones
                  .map((opcion) => DropdownMenuItem(
                      value: opcion,
                      child: Text(
                        opcion,
                        style: TextStyle(fontSize: 18),
                      )))
                  .toList(),
              onChanged: (opcion) => selectedValue = opcion,
            ),
        

       ] 

    ); 
}


Widget campoAsunto(context){
  return Column(
    children: [
      Row(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Text(
              "Asunto:",
              textAlign: TextAlign.left, 
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
                
              ),
          ),
          )
        ], 
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 217, 217, 217),
          ),

        child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child:TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Asunto",
            fillColor: Color.fromARGB(255, 217, 217, 217),
            filled: true,
          ),
        ), 
      )
      )
      
    ],
  );
}

 dateTimePickerWidget(BuildContext context) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        DateTime selectdate = dateTime;
        final selIOS = DateFormat('dd-MMM-yyyy - HH:mm').format(selectdate);
        print(selIOS);
      },
    );
  }

Widget campoFechaHora(context){
  return Column(
    children:[
    Row(
      children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Text(
              "Fecha y hora:",
              textAlign: TextAlign.left, 
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
                
              ),
          ),
          )
        ], 
    ),
      
    SizedBox(
          width: 500,
          height: 50,

          child: ElevatedButton(
            onPressed: () {
                dateTimePickerWidget(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 217, 217, 217),
              foregroundColor: Colors.black,
              textStyle: const TextStyle(
                
              )
              
            ),
            child: const Text('Selecciona fecha y hora'),
          )


    )
    
  ] 
  );
}

Widget botonAgregar(context) {
  return Container(
    padding: const EdgeInsets.only(top: 15),
    child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              foregroundColor: Colors.black,
              backgroundColor: Color.fromARGB(255, 217, 217, 217),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BalanceGeneral(),
                  ));
            },
            child: const Text(
              "Agregar",
              style: TextStyle(fontSize: 25),
            )
      )



  );
  
  
}
