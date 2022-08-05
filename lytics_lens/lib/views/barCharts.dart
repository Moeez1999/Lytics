import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'graphs.dart';

class Charts extends StatelessWidget {
  final List<GraphData> data;

  Charts(this.data);

  // final Color whiteColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    var axis = charts.NumericAxisSpec(
      renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
          fontSize: 10,
          color: charts.ColorUtil.fromDartColor(Colors.white),
        ),
      ),
    );

    List<charts.Series<GraphData, String>> series = [
      charts.Series(
        seriesColor: charts.ColorUtil.fromDartColor(Colors.white),
        id: "Data",
        data: data,
        domainFn: (GraphData graph, _) => graph.category,
        measureFn: (GraphData graph, _) => graph.value,
        colorFn: (GraphData graph, _) => graph.barColor,
      )
    ];
    return charts.BarChart(
      series,
      animate: true,
      vertical: false,
      primaryMeasureAxis: axis,
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
              fontSize: 10, // size in Pts.
              color: charts.MaterialPalette.white),
          // Change the line colors to match text color.
          lineStyle:
              charts.LineStyleSpec(color: charts.MaterialPalette.transparent),
        ),
      ),
      secondaryMeasureAxis: axis,
    );
  }
}
