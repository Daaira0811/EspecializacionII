class Cuenta{
  int? id;
  String? nombreCuenta;
  int? saldo;
  String? moneda;
  String? color;

  Cuenta({  this.id,  this.nombreCuenta,  this.saldo,  this.moneda,  this.color});

  Map <String, dynamic> toMap(){
    return {
      'id':id,
      'nombreCuenta': nombreCuenta,
      'saldo':saldo,
      'moneda':moneda,
      'color':color
      };
  }

  static Cuenta fromMap(Map map) {
    Cuenta cuenta = new Cuenta();
    cuenta.id = map['id'];
    cuenta.nombreCuenta = map['nombreCuenta'];
    cuenta.saldo = map['saldo'];
    cuenta.moneda = map['moneda'];
    cuenta.color = map['color'];

    return cuenta;
  }

}