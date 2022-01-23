import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

@override
progressCalender(BuildContext context) {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: EdgeInsets.all(20),
              child: Scaffold(
                appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close)),
                    title: Text('Progress'),
                    actions: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
                    ]),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TableCalendar(
                          focusedDay: selectedDay,
                          firstDay: DateTime(1990), //Need update
                          lastDay: DateTime(2990),
                          startingDayOfWeek:
                              StartingDayOfWeek.monday, //Dont need
                          daysOfWeekVisible: true,
                          // Day Changed
                          onDaySelected:
                              (DateTime selectDay, DateTime focusDay) {
                            setState(() {
                              selectedDay = selectDay;
                              focusedDay = focusDay;
                            });
                          },
                          selectedDayPredicate: (DateTime date) {
                            return isSameDay(selectedDay, date);
                          },
                          // To style Calender
                          calendarStyle: CalendarStyle(
                              isTodayHighlighted: true,
                              selectedDecoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.rectangle,
                              ),
                              todayDecoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.rectangle,
                              )),
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                          )),
                    ),
                    Text('Daily goals compleated: 0'),
                    SizedBox(height: 14),
                    Opacity(
                        opacity: 0.5,
                        child: Text(
                            'The collection of stats started on 10/09/2021')),
                    SizedBox(height: 5)
                  ],
                ),
              ),
            );
          },
        );
      });
}
