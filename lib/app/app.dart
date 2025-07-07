import 'package:apati_paseo_perro/features/home/presentation/screens/home_screen.dart';
import 'package:apati_paseo_perro/features/walks/data/services/database_service.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(databaseService: DatabaseService()),
    );
  }
}
