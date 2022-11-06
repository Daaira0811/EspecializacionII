

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors



import 'package:flutter/material.dart';
import 'package:flutter_application_fincet/login.dart';

class Registrarse extends StatelessWidget {
  const Registrarse({super.key});

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
    /*
    decoration: BoxDecoration(
      image: DecorationImage(image: NetworkImage("https://i.pinimg.com/originals/62/b8/36/62b836f9037d62691f11b41b5025f0b4.jpg"),
      fit: BoxFit.cover
      )
     
    ),
    */
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 150,),
          signIn(),
          campoUsuario(),
          campoClave(),
          campoReingresarClave(),
          SizedBox(height: 15,),
         
          Column(
             mainAxisAlignment: MainAxisAlignment.center,
      
            children: [         
              botonRegistrar(context),
              SizedBox(height: 15,),
              botonLogear(context),
            ],
          ),

        ],
      ),
      ),
    );
}

Widget signIn(){
  return Text("Registrarse", 
  style: TextStyle(color: Colors.white, 
  fontSize: 30,
  fontWeight: FontWeight.bold),);
}

Widget campoUsuario(){
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

Widget campoReingresarClave(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Reingrese clave",
        fillColor: Color.fromARGB(255,  217, 217, 217),
        filled: true,
        
      ),
    ),
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
    Navigator.push(context,
     MaterialPageRoute(builder: (context)=>Login()));
   },
   child: Text("Registrarse",
   style: TextStyle(fontSize: 20),)
   );
}

Widget botonLogear(context){
  return TextButton(
   style: TextButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    foregroundColor: Colors.black,
    backgroundColor: Color.fromARGB(255,217, 217, 217) 
   ),
 
   onPressed: (){
    Navigator.push(context,
     MaterialPageRoute(builder: (context)=>Login()));
   },
   child: Text("Iniciar sesion",
   style: TextStyle(fontSize: 20),)
   );
}