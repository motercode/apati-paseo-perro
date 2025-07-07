import 'package:apati_paseo_perro/app/app.dart';
import 'package:apati_paseo_perro/features/home/presentation/screens/home_screen.dart';
import 'package:apati_paseo_perro/features/walks/data/services/database_service.dart';
import 'package:apati_paseo_perro/features/walks/domain/models/walk_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_screen_test.mocks.dart';

// Esta anotación le dice a build_runner que genere un archivo de mock
// para DatabaseService.
@GenerateMocks([DatabaseService])
void main() {
  late MockDatabaseService mockDatabaseService;

  setUp(() {
    mockDatabaseService = MockDatabaseService();
  });

  testWidgets('HomeScreen displays walks from database', (WidgetTester tester) async {
    // 1. Preparamos los datos de prueba
    final testWalks = [
      Walk(id: '1', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(hours: 1)), notes: 'Test walk 1'),
      Walk(id: '2', startTime: DateTime.now(), endTime: DateTime.now().add(const Duration(hours: 1)), notes: 'Test walk 2'),
    ];

    // 2. Configuramos el mock ANTES de renderizar el widget
    when(mockDatabaseService.readAll()).thenAnswer((_) async => testWalks);

    // 3. Renderizamos el widget, inyectando nuestro mock.
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(databaseService: mockDatabaseService),
    ));

    // 4. Verificamos el estado de carga inicial
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // 5. Avanzamos el tiempo para que el Future se complete
    await tester.pump();

    // 6. Verificamos que el indicador de carga ha desaparecido
    expect(find.byType(CircularProgressIndicator), findsNothing);
    
    // 7. Verificamos que los datos se muestran
    expect(find.textContaining('Test walk 1'), findsOneWidget);
    expect(find.textContaining('Test walk 2'), findsOneWidget);
  });
}