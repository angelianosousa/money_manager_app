import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovementForm extends StatefulWidget {
  final Function(String title, double value, DateTime date) onSubmit;

  const MovementForm(this.onSubmit, {super.key});

  @override
  State<MovementForm> createState() => _MovementFormState();
}

class _MovementFormState extends State<MovementForm> {
  final formTitle = TextEditingController();
  final formValue = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = formTitle.text;
    final value = double.tryParse(formValue.text) ?? 0.0;

    if (title.isEmpty || value <= 0) return;

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        _selectedDate = pickedDate!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Text(
              'New Move',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: formTitle,
              // onSubmitted: _submitForm(),
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: formValue,
              // onSubmitted: _submitForm(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Value (R\$)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Data escolhida: ${DateFormat('d MMM y').format(_selectedDate)}"),
                TextButton(
                  onPressed: _showDatePicker,
                  child: const Text('Selecione uma data'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).primaryColor,
                    )),
                    onPressed: _submitForm,
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
