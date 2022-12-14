import 'dart:ffi';

class Dinero{
  int? id;
  int? idCuenta;
  int? monto;
  String? asunto;
  String? fechaHora;
  String? tipoOperacion;

  Dinero({  this.id,  this.idCuenta,  this.monto,  this.asunto,  this.fechaHora, this.tipoOperacion});

  Map <String, dynamic> toMap(){
    return {
      'id':id,
      'idCuenta': id,
      'monto':monto,
      'asunto':asunto,
      'fechaHora':fechaHora,
      'tipoOperacion':tipoOperacion
      };
  }

    static Dinero fromMap(Map map) {
    Dinero gasto = Dinero();
    gasto.id = map['id'];
    gasto.idCuenta = map['idCuenta'];
    gasto.monto = map['monto'];
    gasto.asunto = map['asunto'];
    gasto.fechaHora = map['fechaHora'];
    gasto.tipoOperacion = map['tipoOperacion'];

    return gasto;
  }


}