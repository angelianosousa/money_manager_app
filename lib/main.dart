import 'dart:math';

import 'package:flutter/material.dart';
import 'components/movements/charts/movements_chart.dart';
import 'components/movements/movement_form.dart';
import 'components/movements/movement_list.dart';
import 'models/movement.dart';

main() => runApp(const MoneyManagerApp());

class MoneyManagerApp extends StatelessWidget {
  const MoneyManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        primaryColor: Colors.indigo,
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontSize: 18,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
              titleSmall: const TextStyle(
                fontSize: 15,
                fontFamily: 'OpenSans',
              ),
            ),
        appBarTheme: ThemeData().appBarTheme.copyWith(
              color: Colors.indigo,
              foregroundColor: Colors.white,
              titleTextStyle: const TextStyle(
                fontFamily: 'Marriweather',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Movement> _movements = [
    Movement(
      id: 1,
      title: "Livro: Psicologia Financeira",
      value: 100.0,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Movement(
      id: 2,
      title: "Livro: Pai Rico, Pai Pobre",
      value: 200.0,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Movement(
      id: 3,
      title: "Livro: Pensa e Enriqueça",
      value: 300.0,
      date: DateTime.now(),
    ),
    Movement(
      id: 4,
      title: "Livro: O Homem Mais Rico da Babilônia",
      value: 600.0,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
  ];

  _addMovement(String title, double value, DateTime date) {
    final newMove = Movement(
      id: Random().nextInt(100),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _movements.add(newMove);
    });

    Navigator.of(context).pop();
  }

  _deleteMovement(int index) {
    setState(() {
      _movements.remove(_movements[index]);
    });
  }

  _openMovementForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return MovementForm(_addMovement);
      },
    );
  }

  List<Movement> get _movementsLastSevenDays {
    return _movements.where((move) {
      return move.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Manager'),
        actions: [
          IconButton(
            onPressed: () => _openMovementForm(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              MovementsChart(_movementsLastSevenDays),
              const SizedBox(height: 20.0),
              MovementList(_movements, _deleteMovement),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openMovementForm(context),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
