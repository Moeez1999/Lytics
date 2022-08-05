/// Package imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Controllers/reports_controller.dart';
import 'package:lytics_lens/Models/simplechartmodel.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Render the pie series with smart labels.
class PieSmartDataLabels extends SampleView {
  const PieSmartDataLabels({
    Key? key,
  }) : super(key: key);

  @override
  _PieSmartDataLabelsState createState() => _PieSmartDataLabelsState();
}

/// State class of pie series with smart labels.
class _PieSmartDataLabelsState extends SampleViewState {
  _PieSmartDataLabelsState();
  List<String>? _labelIntersectActionList;
  TooltipBehavior? _tooltipBehavior;
  late LabelIntersectAction _labelIntersectAction;
  ReportsController reportsController = Get.put(ReportsController());
  ReportsController _ = Get.find<ReportsController>();

  @override
  Widget build(BuildContext context) {
    return _buildSmartLabelPieChart();
  }

  /// Returns the circular charts with pie series.
  SfCircularChart _buildSmartLabelPieChart() {
    return SfCircularChart(
      title: ChartTitle(
          text: isCardView ? '' : 'Gold medals count in Rio Olympics'),
      series: _gettSmartLabelPieSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  /// Returns the pie series with smart data labels.
  List<PieSeries<ChartSampleData, String>> _gettSmartLabelPieSeries() {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          name: 'RIO',
          dataSource: _.chartdata,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) =>
              data.x + ': ' + (data.y).toString() as String,
          radius: '60%',
          dataLabelSettings: DataLabelSettings(
              margin: EdgeInsets.zero,
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              connectorLineSettings: const ConnectorLineSettings(
                  type: ConnectorType.curve, length: '20%'),
              labelIntersectAction: _labelIntersectAction))
    ];
  }

  @override
  void initState() {
    _labelIntersectAction = LabelIntersectAction.shift;
    _tooltipBehavior = TooltipBehavior(enable: true, header: '');
    super.initState();
  }

  @override
  void dispose() {
    _labelIntersectActionList!.clear();
    super.dispose();
  }
}
