import 'package:flutter/material.dart';
import 'package:flutter_application_fincet/balanceGastos.dart';
import 'package:flutter_application_fincet/misCuentas.dart';

import '../balanceIngresos.dart';

class sideMenu extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 46, 46, 46),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 200,
            child: DrawerHeader(
                  decoration: BoxDecoration(
                        color:  Color.fromARGB(255, 96, 95, 95),
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.white, fontSize: 25),             
                  ),
                ),
          ),
      
          ListTile(
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.money_off),
            title: Text('Balance gastos'),
            onTap: () => {Navigator.push(
              context, MaterialPageRoute(
              builder: (context)=> const BalanceGastos()
            ))},
          ),
          ListTile(
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.attach_money),
            title: Text('Balance ingresos'),
            onTap: () => {Navigator.push(
              context, MaterialPageRoute(
              builder: (context)=> const BalanceIngresos()
            ))},
          ),
          ListTile(
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Cuentas'),
            onTap: () => {Navigator.push(
              context, MaterialPageRoute(
              builder: (context)=> const mostrarCuentas()
            ))},
          ),
          
        ],
      ),
      
    );
  }
}
