import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/components/movements/charts/chart_bar.dart';
import 'package:money_manager/models/movement.dart';

class MovementsChart extends StatelessWidget {
  final List<Movement> lastMovements;

  const MovementsChart(this.lastMovements, {super.key});

  List<Map<String, Object>> get _groupedMovements {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSumOfThatDay = 0.0;

      for (var i = 0; i < lastMovements.length; i++) {
        bool sameDay = lastMovements[i].date.day == weekDay.day;
        bool sameMonth = lastMovements[i].date.month == weekDay.month;
        bool sameYear = lastMovements[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSumOfThatDay += lastMovements[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'total': totalSumOfThatDay,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return _groupedMovements.fold(0.0, (sum, item) {
      return sum + (item['total'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Money in 7 days',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _groupedMovements.map((weekDay) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      total: weekDay['total'] as double,
                      percentage: _weekTotalValue == 0
                          ? 0
                          : ((weekDay['total'] as double) / _weekTotalValue) *
                              100.0,
                      weekDay: weekDay['day'].toString(),
                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}
