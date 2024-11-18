import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double total;
  final double percentage;
  final String weekDay;

  const ChartBar(
      {super.key,
      required this.total,
      required this.percentage,
      required this.weekDay});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text(total.toStringAsFixed(2))),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 100,
              width: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(220, 220, 220, 1),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: percentage,
              width: 10,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
        Text(weekDay),
      ],
    );
  }
}
