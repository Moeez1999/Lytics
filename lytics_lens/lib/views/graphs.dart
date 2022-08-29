import 'package:charts_flutter/flutter.dart' as charts;

class GraphData {
  final String category;
  final int value;
  final charts.Color barColor;

  GraphData(this.category, this.value, this.barColor);
}
