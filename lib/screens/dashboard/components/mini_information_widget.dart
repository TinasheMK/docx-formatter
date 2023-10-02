import 'package:docxform/core/constants/color_constants.dart';
import 'package:docxform/screens/clients/clients_home_screen.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/models/daily_info_model.dart';
import '../../../core/utils/responsive.dart';
import '../../register/new/new_register_home_screen.dart';
import '../../zimra/new/new_zimra_home_screen.dart';

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
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                  color: widget.dailyData.color!.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(
                  widget.dailyData.icon,
                  color: widget.dailyData.color,
                  size: 18,
                ),
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.dailyData.color!.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(defaultPadding * 0.75),
                            child: Text(
                            "New",
                            ),
                          )
                        ),
                        onTap: () {
                          if(widget.dailyData.title=="DEEDS"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NewRegisterHome(title: widget.dailyData.title! , code: widget.dailyData.code != null?
                              widget.dailyData.code!:"reg")),
                            );
                          }else if(widget.dailyData.title=="ZIMRA"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NewZimraHome(title: 'ZIMRA', code: 'wiw',)),
                            );
                          }else if(widget.dailyData.title=="PRAZ"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NewZimraHome(title: 'PRAZ', code: 'wiw',)),
                            );
                          }else if(widget.dailyData.title=="CLIENT"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ClientsHomeScreen()),
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Feature not yet available"),
                            ));
                          }
                        }
                    ),
                    ]
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.dailyData.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 8,
              ),
              // Container(
              //   child: LineChartWidget(
              //     colors: widget.dailyData.colors,
              //     spotsData: widget.dailyData.spots,
              //   ),
              // )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          ProgressLine(
            color: widget.dailyData.color!,
            percentage: widget.dailyData.percentage!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.dailyData.volumeData}",
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white70),
              ),
              // Text(
              //   widget.dailyData.totalStorage!,
              //   style: Theme.of(context)
              //       .textTheme
              //       .caption!
              //       .copyWith(color: Colors.white),
              // ),
            ],
          )
        ],
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
