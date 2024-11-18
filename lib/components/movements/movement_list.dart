import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/models/movement.dart';

class MovementList extends StatelessWidget {
  final List<Movement> movements;
  final Function(int) _onDelete;

  const MovementList(this.movements, this._onDelete, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: movements.isEmpty
          ? Column(
              children: [
                Text(
                  'Faça uma movimentação!!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 120,
                  child: Image.asset(
                    'assets/images/wait.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: movements.length,
              itemBuilder: (ctx, index) {
                final move = movements[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            "R\$ ${move.value.toStringAsFixed(2)}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      move.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(move.date),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        _onDelete(index);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
