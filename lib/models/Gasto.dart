class Gasto{
  int? id;
  int? idCuenta;
  int? monto;
  String? asunto;
  String? fechaHora;

  Gasto({  this.id,  this.idCuenta,  this.monto,  this.asunto,  this.fechaHora});

  Map <String, dynamic> toMap(){
    return {
      'id':id,
      'idCuenta': id,
      'monto':monto,
      'asunto':asunto,
      'fechaHora':fechaHora
      };
  }

    static Gasto fromMap(Map map) {
    Gasto gasto = new Gasto();
    gasto.id = map['id'];
    gasto.idCuenta = map['idCuenta'];
    gasto.monto = map['monto'];
    gasto.asunto = map['asunto'];
    gasto.fechaHora = map['fechaHora'];

    return gasto;
  }


}