import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/types/daily_info_model.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/screens/quote/quotes_home_screen.dart';
import 'package:smart_admin_dashboard/screens/quote/quotes_screen.dart';
import 'package:smart_admin_dashboard/screens/receipt/receipts_home_screen.dart';

import '../../../core/utils/responsive.dart';
import '../../client/clients_home_screen.dart';
import '../../client/edit/client_home_screen.dart';
 import '../../invoice/edit/invoice_home_screen.dart';
import '../../invoice/invoices_home_screen.dart';

class MiniInformationWidget extends StatefulWidget {
  const MiniInformationWidget({
    Key? key,
    required this.dailyData,
  }) : super(key: key);

  final DailyInfoModel dailyData;

  @override
  _MiniInformationWidgetState createState() => _MiniInformationWidgetState();
}

int _value = 1;

class _MiniInformationWidgetState extends State<MiniInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        // color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SizedBox(
        child:
        GestureDetector(
            child: Container(
              // padding: EdgeInsets.all(defaultPadding * 0.75),
              alignment: Alignment.center,
              // height: 40,
              // width: 175,
              decoration: BoxDecoration(
                color: widget.dailyData.color!.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(widget.dailyData.title!, style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),
              ),
            ),
            onTap: () {
              // Navigator.of(context).push(new MaterialPageRoute<Null>(
              //     builder: (BuildContext context) {
                    if(widget.dailyData.code == 'newin') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuotesHomeScreen()),
                      );
                    }else if(widget.dailyData.code == 'newclie'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReceiptsHomeScreen()),
                      );
                    }else if(widget.dailyData.code == 'clients'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ClientsHomeScreen()),
                      );
                    }else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterHomeScreen()),
                      );
                    }
                    // return new NewTask(dailyData: widget.dailyData,);

                  // },
                  // fullscreenDialog: true));
            }
        ),
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    Key? key,
    required this.colors,
    required this.spotsData,
  }) : super(key: key);
  final List<Color>? colors;
  final List<FlSpot>? spotsData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 30,
          child: LineChart(
            LineChartData(
                lineBarsData: [
                  LineChartBarData(
                      spots: spotsData,
                      belowBarData: BarAreaData(show: false),
                      aboveBarData: BarAreaData(show: false),
                      isCurved: true,
                      dotData: FlDotData(show: false),
                      colors: colors,
                      barWidth: 3),
                ],
                lineTouchData: LineTouchData(enabled: false),
                titlesData: FlTitlesData(show: false),
                axisTitleData: FlAxisTitleData(show: false),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false)),
          ),
        ),
      ],
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color color;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
