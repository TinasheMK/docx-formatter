import 'package:intl/intl.dart';

class CalendarData {
  final String name;

  final DateTime date;
  final String position;
  final String rating;

  String getDate() {
    final formatter = DateFormat('kk:mm');

    return formatter.format(date);
  }

  CalendarData({
    required this.name,
    required this.date,
    required this.position,
    required this.rating,
  });
}

final List<CalendarData> calendarData = [
  CalendarData(
    name: 'Tapmub Consultancy',
    date: DateTime.now().add(Duration(days: -16, hours: 5)),
    position: "Registration",
    rating: '₽',
  ),
  CalendarData(
    name: 'Laka PVT',
    date: DateTime.now().add(Duration(days: -5, hours: 8)),
    position: "Tax Clearing",
    rating: '₽',
  ),
  CalendarData(
    name: 'Joy Barker',
    date: DateTime.now().add(Duration(days: -10, hours: 3)),
    position: "CR5",
    rating: '\$',
  ),
  CalendarData(
    name: 'Kate Hartley',
    date: DateTime.now().add(Duration(days: 6, hours: 6)),
    position: "CR6",
    rating: '\$',
  ),
  CalendarData(
    name: 'Fletcher Robson',
    date: DateTime.now().add(Duration(days: -18, hours: 9)),
    position: "Tax",
    rating: '\$',
  ),
  CalendarData(
    name: 'Aldrich Mason',
    date: DateTime.now().add(Duration(days: -12, hours: 2)),
    position: "Tax",
    rating: '\$',
  ),
  CalendarData(
    name: 'Phyllis Leonard',
    date: DateTime.now().add(Duration(days: -8, hours: 4)),
    position: "CR5",
    rating: '\$',
  ),

];
