import 'package:flutter/material.dart';
import 'package:flutter_application_fincet/balanceGastos.dart';

import '../balanceIngresos.dart';

class sideMenu extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color:  const Color.fromARGB(255, 96, 95, 95),
                ),
          ),
          ListTile(
            leading: Icon(Icons.money_off),
            title: Text('Balance gastos'),
            onTap: () => {Navigator.push(
              context, MaterialPageRoute(
              builder: (context)=> const BalanceGastos()
            ))},
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Balance ingresos'),
            onTap: () => {Navigator.push(
              context, MaterialPageRoute(
              builder: (context)=> const BalanceIngresos()
            ))},
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Cuentas'),
            onTap: () => {Navigator.push(
              context, MaterialPageRoute(
              builder: (context)=> const BalanceIngresos()
            ))},
          ),
          
        ],
      ),
    );
  }
}
