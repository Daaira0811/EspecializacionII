
import 'package:charts_flutter/flutter.dart' as charts;

// Clase para crear los graficos 
class Gastos {
  final int dinero;
  final String dias;
  final charts.Color barColor;
  final String tipo;

  Gastos(
    this.dinero,
    this.dias,
    this.barColor, 
    this.tipo
    
  );
}

