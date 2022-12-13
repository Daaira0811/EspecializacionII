class Ingreso{
  int? id;
  int? idCuenta;
  int? monto;
  String? asunto;
  String? fechaHora;

  Ingreso({  this.id,  this.idCuenta,  this.monto,  this.asunto,  this.fechaHora});

  Map <String, dynamic> toMap(){
    return {
      'id':id,
      'idCuenta': id,
      'monto':monto,
      'asunto':asunto,
      'fechaHora':fechaHora
      };
  }
  static Ingreso fromMap(Map map) {
    Ingreso ingreso = new Ingreso();
    ingreso.id = map['id'];
    ingreso.idCuenta = map['idCuenta'];
    ingreso.monto = map['monto'];
    ingreso.asunto = map['asunto'];
    ingreso.fechaHora = map['fechaHora'];

    return ingreso;
  }

}