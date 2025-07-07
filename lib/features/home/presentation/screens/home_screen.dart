
import 'package:apati_paseo_perro/features/walks/domain/models/walk_model.dart';
import 'package:apati_paseo_perro/features/walks/presentation/screens/walk_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista de ejemplo (mock data)
  final List<Walk> _walks = [
    Walk(
      id: '1',
      startTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      endTime: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
      notes: 'Paseo matutino por el parque. Todo tranquilo.',
    ),
    Walk(
      id: '2',
      startTime: DateTime.now().subtract(const Duration(hours: 5)),
      endTime: DateTime.now().subtract(const Duration(hours: 4)),
      notes: 'Paseo de tarde. Jugamos a la pelota.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paseos de Perro'),
      ),
      body: _walks.isEmpty
          ? const Center(
              child: Text('Aún no has registrado ningún paseo.'),
            )
          : ListView.builder(
              itemCount: _walks.length,
              itemBuilder: (context, index) {
                final walk = _walks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      'Paseo del ${DateFormat('dd/MM/yyyy').format(walk.startTime)}',
                    ),
                    subtitle: Text(
                      '''De ${DateFormat('HH:mm').format(walk.startTime)} a ${DateFormat('HH:mm').format(walk.endTime)}
${walk.notes}''',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WalkFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
