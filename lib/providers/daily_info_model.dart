import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DailyInfoModel {
  IconData? icon;
  String? title;
  String? code;
  String? totalStorage;
  int? volumeData;
  int? percentage;
  Color? color;
  List<Color>? colors;
  List<FlSpot>? spots;

  DailyInfoModel({
    this.icon,
    this.title,
    this.code,
    this.totalStorage,
    this.volumeData,
    this.percentage,
    this.color,
    this.colors,
    this.spots,
  });

  DailyInfoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    volumeData = json['volumeData'];
    icon = json['icon'];
    code = json['code'];
    totalStorage = json['totalStorage'];
    color = json['color'];
    percentage = json['percentage'];
    colors = json['colors'];
    spots = json['spots'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['volumeData'] = this.volumeData;
    data['icon'] = this.icon;
    data['code'] = this.code;
    data['totalStorage'] = this.totalStorage;
    data['color'] = this.color;
    data['percentage'] = this.percentage;
    data['colors'] = this.colors;
    data['spots'] = this.spots;
    return data;
  }
}

List<DailyInfoModel> dailyDatas =
    dailyData.map((item) => DailyInfoModel.fromJson(item)).toList();

List<DailyInfoModel> billings =
billing.map((item) => DailyInfoModel.fromJson(item)).toList();

List<DailyInfoModel> prazs =
praz.map((item) => DailyInfoModel.fromJson(item)).toList();

List<DailyInfoModel> zimras =
zimra.map((item) => DailyInfoModel.fromJson(item)).toList();

List<DailyInfoModel> clients =
client.map((item) => DailyInfoModel.fromJson(item)).toList();

//List<FlSpot> spots = yValues.asMap().entries.map((e) {
//  return FlSpot(e.key.toDouble(), e.value);
//}).toList();

var dailyData = [

  {
    "title": "INVOICES",
    "code": "invoices",
    "volumeData": 1328,
    "icon": FlutterIcons.message1_ant,
    "totalStorage": "+ %5",
    "color": Color(0xFFFFA113),
    "percentage": 35,
    "colors": [Color(0xfff12711), Color(0xfff5af19)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        1.0,
      ),
      FlSpot(
        3,
        4,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        3,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },
  {
    "title": "CLIENTS",
    "code": "clients",
    "volumeData": 1328,
    "icon": FlutterIcons.comment_alt_faw5s,
    "totalStorage": "+ %8",
    "color": Color(0xFFA4CDFF),
    "percentage": 10,
    "colors": [Color(0xff2980B9), Color(0xff6DD5FA)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        5,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        6,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1,
      )
    ]
  },
  {
    "title": "NEW INVOICE",
    "code": "newin",
    "volumeData": 1328,
    "icon": FlutterIcons.heart_faw5s,
    "totalStorage": "+ %8",
    "color": Color(0xFFd50000),
    "percentage": 10,
    "colors": [Color(0xff93291E), Color(0xffED213A)],
    "spots": [
      FlSpot(
        1,
        3,
      ),
      FlSpot(
        2,
        4,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },
  {
    "title": "NEW CLIENT",
    "code": "newclie",
    "volumeData": 1328,
    "icon": FlutterIcons.user_alt_faw5s,
    "totalStorage": "+ %20",
    "color": primaryColor,
    "percentage": 35,
    "colors": [
      Color(0xff23b6e6),
      Color(0xff02d39a),
    ],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        1.0,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },

];




var billing = [

  {
    "title": "New Invoice",
    "code": "reg",
    "volumeData": 1328,
    "icon": FlutterIcons.message1_ant,
    "totalStorage": "+ %5",
    "color": Color(0xFFFFA113),
    "percentage": 35,
    "colors": [Color(0xfff12711), Color(0xfff5af19)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        1.0,
      ),
      FlSpot(
        3,
        4,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        3,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },
  {
    "title": "Paid Invoices",
    "code": "cr6",
    "volumeData": 1328,
    "icon": FlutterIcons.comment_alt_faw5s,
    "totalStorage": "+ %8",
    "color": Color(0xFFA4CDFF),
    "percentage": 10,
    "colors": [Color(0xff2980B9), Color(0xff6DD5FA)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        5,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        6,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1,
      )
    ]
  },
  {
    "title": "Draft Invoices",
    "code": "cr5",
    "volumeData": 1328,
    "icon": FlutterIcons.heart_faw5s,
    "totalStorage": "+ %8",
    "color": Color(0xFFd50000),
    "percentage": 10,
    "colors": [Color(0xff93291E), Color(0xffED213A)],
    "spots": [
      FlSpot(
        1,
        3,
      ),
      FlSpot(
        2,
        4,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },
  {
    "title": "Unpaid Invoices",
    "code": "cr11",
    "volumeData": 1328,
    "icon": FlutterIcons.user_alt_faw5s,
    "totalStorage": "+ %20",
    "color": primaryColor,
    "percentage": 35,
    "colors": [
      Color(0xff23b6e6),
      Color(0xff02d39a),
    ],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        1.0,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },
  {
    "title": "Overdue Invoices",
    "code": "cr3",
    "volumeData": 5328,
    "icon": FlutterIcons.bell_faw5s,
    "totalStorage": "- %5",
    "color": Color(0xFF00F260),
    "percentage": 78,
    "colors": [Color(0xff0575E6), Color(0xff00F260)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        1.0,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },
  {
    "title": "Cancelled Invoices",
    "code": "returns",
    "volumeData": 5328,
    "icon": FlutterIcons.bell_faw5s,
    "totalStorage": "- %5",
    "color": Color(0xFF00F260),
    "percentage": 78,
    "colors": [Color(0xff0575E6), Color(0xff00F260)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        1.0,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },
  {
    "title": "Refunded Invoices",
    "code": "returns",
    "volumeData": 5328,
    "icon": FlutterIcons.bell_faw5s,
    "totalStorage": "- %5",
    "color": Color(0xFF00F260),
    "percentage": 78,
    "colors": [Color(0xff0575E6), Color(0xff00F260)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        1.0,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },

];


var zimra = [

  {
    "title": "ZIMRA Registration",
    "volumeData": 1328,
    "icon": FlutterIcons.message1_ant,
    "totalStorage": "+ %5",
    "color": Color(0xFFFFA113),
    "percentage": 35,
    "colors": [Color(0xfff12711), Color(0xfff5af19)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        1.0,
      ),
      FlSpot(
        3,
        4,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        3,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },
  {
    "title": "ZIMRA Renewal",
    "volumeData": 1328,
    "icon": FlutterIcons.comment_alt_faw5s,
    "totalStorage": "+ %8",
    "color": Color(0xFFA4CDFF),
    "percentage": 10,
    "colors": [Color(0xff2980B9), Color(0xff6DD5FA)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        5,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        6,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1,
      )
    ]
  },

];


var praz = [

  {
    "title": "Praz Registration",
    "volumeData": 1328,
    "icon": FlutterIcons.message1_ant,
    "totalStorage": "+ %5",
    "color": Color(0xFFFFA113),
    "percentage": 35,
    "colors": [Color(0xfff12711), Color(0xfff5af19)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        1.0,
      ),
      FlSpot(
        3,
        4,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        3,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },
  {
    "title": "PRAZ Renewal",
    "volumeData": 1328,
    "icon": FlutterIcons.comment_alt_faw5s,
    "totalStorage": "+ %8",
    "color": Color(0xFFA4CDFF),
    "percentage": 10,
    "colors": [Color(0xff2980B9), Color(0xff6DD5FA)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        5,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        6,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1,
      )
    ]
  },

];


var client = [

  {
    "title": "Client",
    "volumeData": 1328,
    "icon": FlutterIcons.message1_ant,
    "totalStorage": "+ %5",
    "color": Color(0xFFFFA113),
    "percentage": 35,
    "colors": [Color(0xfff12711), Color(0xfff5af19)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        1.0,
      ),
      FlSpot(
        3,
        4,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        3,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },

];