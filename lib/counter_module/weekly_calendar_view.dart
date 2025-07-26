import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyCalendarView extends StatefulWidget {
  @override
  _WeeklyCalendarViewState createState() => _WeeklyCalendarViewState();
}

class _WeeklyCalendarViewState extends State<WeeklyCalendarView> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final weekDates = _getWeekDates(_currentDate);
    final monthName = DateFormat('MMMM y').format(_currentDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Week navigation buttons
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'My Activity',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     IconButton(
        //       icon: Icon(Icons.chevron_left),
        //       onPressed: _previousWeek,
        //     ),
        //     Text(
        //       'Week of ${DateFormat('MMM d').format(weekDates.first)}',
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //     ),
        //     IconButton(
        //       icon: Icon(Icons.chevron_right),
        //       onPressed: _nextWeek,
        //     ),
        //   ],
        // ),

        // Weekday headers
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: weekDates.map((date) {
                    return Expanded(
                      child: Column(
                        children: [
                          Text(
                            _getDayLetter(date),
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _isToday(date)
                                  ? Colors.blue
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              _getDayNumber(date),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: _isToday(date)
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: _isToday(date)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _getMonthAbbreviation(date),
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4C0E0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                    onTap: _nextWeek,
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    )),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  String _getWeekRangeString(List<DateTime> weekDates) {
    final format = DateFormat('MMM d');
    return '${format.format(weekDates.first)} - ${format.format(weekDates.last)}';
  }

  String _getMonthAbbreviation(DateTime date) {
    return DateFormat('MMM').format(date);
  }

  List<DateTime> _getWeekDates(DateTime date) {
    final firstDay = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => firstDay.add(Duration(days: index)));
  }

  String _getDayLetter(DateTime date) {
    return DateFormat('E').format(date).substring(0, 1);
  }

  String _getDayNumber(DateTime date) {
    return DateFormat('d').format(date);
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  void _nextWeek() {
    setState(() {
      _currentDate = _currentDate.add(Duration(days: 7));
    });
  }

  void _previousWeek() {
    setState(() {
      _currentDate = _currentDate.subtract(Duration(days: 7));
    });
  }
}
