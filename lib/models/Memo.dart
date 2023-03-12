import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Memo {
  IconData? icon;
  String? title;
  String? code;
  String? description;
  int? volumeData;
  int? percentage;
  String? set;
  List<Color>? colors;
  List<FlSpot>? spots;

  Memo({
    this.icon,
    this.title,
    this.code,
    this.description,
    this.volumeData,
    this.percentage,
    this.set,
    this.colors,
    this.spots,
  });

  Memo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    volumeData = json['volumeData'];
    icon = json['icon'];
    code = json['code'];
    description = json['description'];
    set = json['set'];
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
    data['description'] = this.description;
    data['set'] = this.set;
    data['percentage'] = this.percentage;
    data['colors'] = this.colors;
    data['spots'] = this.spots;
    return data;
  }
}


List<Memo> memos =
memo.map((item) => Memo.fromJson(item)).toList();

List<Memo> memoInits =
memoInit.map((item) => Memo.fromJson(item)).toList();


//List<FlSpot> spots = yValues.asMap().entries.map((e) {
//  return FlSpot(e.key.toDouble(), e.value);
//}).toList();

var memo = [

  {
    "title": "Kanjan Solutions",
    "code": "1",
    "volumeData": 1328,
    "icon": FlutterIcons.message1_ant,
    "description": " To carry on the business of farming, agriculture and horticulture in all their respective forms and branches and to grow, produce, manufacture, process, prepare, refine, extract,manipulate, hydrolize, grind, bleach hydrogenate, buy, sell or otherwise deal in all kind of agricultural, horticultural dairy and farm produce and products including food grains, cereals, seeds, oilseeds, plants, flowers, vegetable fruits, vegetable and edible oils, meat, fish, eggs and foods and food products and preparations of any nature or description whatsoever and all business incidental thereto.",
    "set": "not",
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
    "title": "Savvy ",
    "code": "2",
    "volumeData": 1328,
    "icon": FlutterIcons.comment_alt_faw5s,
    "description": "To carry on business of timber and lumber merchants, lumber yard and saw mill,shingle mill and to buy, sell, prepare for market, process, import, export and otherwise deal in timber piles and poles, lumber and wood of all kinds and to manufacture and deal in articles of all kinds in the manufacture of which timber or wood or any other forest produce is used, to carry on the business of logging, lumbering, purchasing, acquiring and leasing timber berths ,together with any other business which in the opinion of the directors furthers the aims of this object.",
    "set": "not",
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
    "title": "ZimboSoft",
    "code": "3",
    "volumeData": 1328,
    "icon": FlutterIcons.heart_faw5s,
    "description": "To carry on the trade or business of a construction company which includes building contractors, land developers, civil, electrical and mechanical engineers, carpenters, joiners, painters, decorators, metalworkers, plumbers, as well as buying and selling, supplying and distributing bituminous products, equipment, machinery, apparatus, tools, utensils, commodities, substances timber, boards and all other building materials, leasing and hiring of construction equipment’s and offering architectural work, painting, plumbing, tailing, welding both home or abroad, together with any other business which in the opinion of the directors furthers the aims of this object.",
    "set": "not",
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
    "title": "Econet Wireless",
    "code": "4",
    "volumeData": 1328,
    "icon": FlutterIcons.user_alt_faw5s,
    "description": "To acquire, construct, own, run and manage and to carry on the business of running hotels, motels, holiday camps, guest houses, restaurants, rest rooms, resorts, canteens, food courts, micro-breweries, shops, stores, mobile food counters, eating houses, kiosks, outlets, cafeterias, dine in facility, take away and/or delivery based services, caterers, cafes, taverns, pubs, bars, beer houses, refreshment rooms and lodging or apartments of house keepers, service apartments, night clubs, casinos, discotheques, swimming pools, health clubs, baths, dressing rooms, licensed victuallers, wine, beer and sprit merchants, exporters, importers, and manufacturers of aerated mineral and artificial water and other drinks, purveyors, caterers of public amusement generally and all business incidental thereto.",
    "set": "not",
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

var memoInit = [

  {
    "title": "Agriculture",
    "code": "1",
    "volumeData": 1328,
    "icon": FlutterIcons.message1_ant,
    "description": " To carry on the business of farming, agriculture and horticulture in all their respective forms and branches and to grow, produce, manufacture, process, prepare, refine, extract,manipulate, hydrolize, grind, bleach hydrogenate, buy, sell or otherwise deal in all kind of agricultural, horticultural dairy and farm produce and products including food grains, cereals, seeds, oilseeds, plants, flowers, vegetable fruits, vegetable and edible oils, meat, fish, eggs and foods and food products and preparations of any nature or description whatsoever and all business incidental thereto.",
    "set": "not",
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
    "title": "Timber",
    "code": "2",
    "volumeData": 1328,
    "icon": FlutterIcons.comment_alt_faw5s,
    "description": "To carry on business of timber and lumber merchants, lumber yard and saw mill,shingle mill and to buy, sell, prepare for market, process, import, export and otherwise deal in timber piles and poles, lumber and wood of all kinds and to manufacture and deal in articles of all kinds in the manufacture of which timber or wood or any other forest produce is used, to carry on the business of logging, lumbering, purchasing, acquiring and leasing timber berths ,together with any other business which in the opinion of the directors furthers the aims of this object.",
    "set": "not",
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
    "title": "Construction",
    "code": "3",
    "volumeData": 1328,
    "icon": FlutterIcons.heart_faw5s,
    "description": "To carry on the trade or business of a construction company which includes building contractors, land developers, civil, electrical and mechanical engineers, carpenters, joiners, painters, decorators, metalworkers, plumbers, as well as buying and selling, supplying and distributing bituminous products, equipment, machinery, apparatus, tools, utensils, commodities, substances timber, boards and all other building materials, leasing and hiring of construction equipment’s and offering architectural work, painting, plumbing, tailing, welding both home or abroad, together with any other business which in the opinion of the directors furthers the aims of this object.",
    "set": "not",
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
    "title": "Hotels & Lodges",
    "code": "4",
    "volumeData": 1328,
    "icon": FlutterIcons.user_alt_faw5s,
    "description": "To acquire, construct, own, run and manage and to carry on the business of running hotels, motels, holiday camps, guest houses, restaurants, rest rooms, resorts, canteens, food courts, micro-breweries, shops, stores, mobile food counters, eating houses, kiosks, outlets, cafeterias, dine in facility, take away and/or delivery based services, caterers, cafes, taverns, pubs, bars, beer houses, refreshment rooms and lodging or apartments of house keepers, service apartments, night clubs, casinos, discotheques, swimming pools, health clubs, baths, dressing rooms, licensed victuallers, wine, beer and sprit merchants, exporters, importers, and manufacturers of aerated mineral and artificial water and other drinks, purveyors, caterers of public amusement generally and all business incidental thereto.",
    "set": "not",
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



