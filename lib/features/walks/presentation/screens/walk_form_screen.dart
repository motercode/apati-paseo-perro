
import 'package:apati_paseo_perro/features/walks/domain/models/walk_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalkFormScreen extends StatefulWidget {
  const WalkFormScreen({super.key});

  @override
  State<WalkFormScreen> createState() => _WalkFormScreenState();
}

class _WalkFormScreenState extends State<WalkFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  DateTime? _startTime;
  DateTime? _endTime;

  Future<void> _selectDateTime(BuildContext context, bool isStartTime) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (time == null) return;

    setState(() {
      final selectedDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      if (isStartTime) {
        _startTime = selectedDateTime;
      } else {
        _endTime = selectedDateTime;
      }
    });
  }

  void _saveWalk() {
    if (_formKey.currentState!.validate()) {
      if (_startTime == null || _endTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecciona fecha y hora de inicio y fin.')),
        );
        return;
      }

      final newWalk = Walk(
        id: DateTime.now().toString(), // ID temporal
        startTime: _startTime!,
        endTime: _endTime!,
        notes: _notesController.text,
      );

      // Por ahora, solo imprimimos en la consola
      print('Paseo guardado:');
      print('ID: ${newWalk.id}');
      print('Inicio: ${newWalk.startTime}');
      print('Fin: ${newWalk.endTime}');
      print('Notas: ${newWalk.notes}');

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Paseo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateTimePicker(
                label: 'Inicio del Paseo',
                selectedDate: _startTime,
                onPressed: () => _selectDateTime(context, true),
              ),
              const SizedBox(height: 16),
              _buildDateTimePicker(
                label: 'Fin del Paseo',
                selectedDate: _endTime,
                onPressed: () => _selectDateTime(context, false),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notas',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  // Opcional: puedes añadir validaciones aquí
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _saveWalk,
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? 'No seleccionado'
                      : DateFormat('dd/MM/yyyy HH:mm').format(selectedDate),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
