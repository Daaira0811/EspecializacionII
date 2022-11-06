

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors




import 'package:flutter/material.dart';
import 'package:flutter_application_fincet/balanceGastos.dart';
import 'package:flutter_application_fincet/register.dart';

// aqui solo cambie el nombre de la clase login


class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
        
        appBar: AppBar( 
         centerTitle: true,
         backgroundColor: Color.fromARGB(255,96, 95, 95)  ,
          
          
          title: Text("FINCET",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
          ),
        ),

        body: cuerpo(context)
           
        );
  }
}

Widget cuerpo(context){
  return Container(
    color: Color.fromARGB(255, 46, 46,46),
    child: Center(
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 150,),
          textoIniciarSesion(),

          textoIngresarCorreo(),
          campoUsuario(),
          campoClave(),
          SizedBox(height: 15,),
         
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
      
            children: [         
              botonEntrar(context),
              SizedBox(height: 15,),
              botonRegistrar(context),
            ],
          ),

        ],
      ),
      ),
    );
}

Widget textoIniciarSesion(){
  Row(children: [
    
  ],);
  return Text("Iniciar Sesion", 
  style: TextStyle(color: Colors.white, 
  fontSize: 30,
  fontWeight: FontWeight.bold),
  );
}

Widget textoIngresarCorreo(){
  return Text("Ingrese correo",
   style: TextStyle(color: Colors.white, 
   fontSize: 15,
   fontWeight: FontWeight.normal),
  );
  
}

Widget campoUsuario(){
  Text("Ingrese correo");
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Correo",
        fillColor: Color.fromARGB(255, 217, 217, 217),
        filled: true, 
      ),
    ),
  );
}

Widget campoClave(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Clave",
        fillColor: Color.fromARGB(255,  217, 217, 217),
        filled: true,
      ),
    ),
  );
}

Widget botonEntrar(context){
  return TextButton(
   style: TextButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    foregroundColor: Colors.black,
    backgroundColor: Color.fromARGB(255, 217, 217, 217),
   ),
   onPressed: (){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context)=> BalanceGastos(),));
   }, // aqui deberia redirigir al balance general
   child: Text("Iniciar sesion",
   style: TextStyle(fontSize: 25),)
   );
}

Widget botonRegistrar(context){
  return TextButton(
   style: TextButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
    foregroundColor: Colors.black,
    backgroundColor: Color.fromARGB(255,217, 217, 217),
   ),
 
   onPressed: (){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Registrarse(),));
   },
   child: Text("Registrarse",
   style: TextStyle(fontSize: 25),)
   );
}