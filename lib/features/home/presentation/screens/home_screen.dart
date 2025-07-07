
import 'package:apati_paseo_perro/features/walks/data/services/database_service.dart';
import 'package:apati_paseo_perro/features/walks/domain/models/walk_model.dart';
import 'package:apati_paseo_perro/features/walks/presentation/screens/walk_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final DatabaseService databaseService;

  const HomeScreen({super.key, required this.databaseService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Walk>> _walksFuture;

  @override
  void initState() {
    super.initState();
    _refreshWalks();
  }

  void _refreshWalks() {
    setState(() {
      _walksFuture = widget.databaseService.readAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paseos de Perro'),
      ),
      body: FutureBuilder<List<Walk>>(
        future: _walksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Aún no has registrado ningún paseo.'),
            );
          }

          final walks = snapshot.data!;

          return ListView.builder(
            itemCount: walks.length,
            itemBuilder: (context, index) {
              final walk = walks[index];
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WalkFormScreen(databaseService: widget.databaseService),
            ),
          );
          _refreshWalks(); // Refrescar la lista al volver del formulario
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
