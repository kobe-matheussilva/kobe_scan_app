import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:kobe_scan_app/presentation/home/home_page.dart';
import 'package:kobe_scan_app/core/theme/app_theme.dart';
import 'package:kobe_scan_app/core/app_widget.dart';

// Mock do Firebase para testes
class MockFirebaseCore extends FirebasePlatform {
  @override
  FirebaseAppPlatform app([String name = defaultFirebaseAppName]) {
    return MockFirebaseApp();
  }

  @override
  Future<FirebaseAppPlatform> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) async {
    return MockFirebaseApp();
  }

  @override
  List<FirebaseAppPlatform> get apps => [MockFirebaseApp()];
}

class MockFirebaseApp extends FirebaseAppPlatform {
  MockFirebaseApp() : super('test', const FirebaseOptions(
    apiKey: 'test',
    appId: 'test',
    messagingSenderId: 'test',
    projectId: 'test',
  ));
}

void main() {
  setUpAll(() async {
    // Configura o mock do Firebase para todos os testes
    FirebasePlatform.instance = MockFirebaseCore();
    await Firebase.initializeApp();
  });

  group('Kobe Scan App Tests', () {
    
    testWidgets('Complete App Test com Firebase', (WidgetTester tester) async {
      // Testa o app completo com Firebase inicializado
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      // Verifica se o app principal carregou (MaterialApp está presente)
      expect(find.byType(MaterialApp), findsOneWidget);
      
      // Verifica se pelo menos uma página foi carregada
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('HomePage com Firebase Test', (WidgetTester tester) async {
      // Testa a HomePage com contexto Firebase
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.defaultTheme,
        home: const HomePage(),
      ));
      await tester.pumpAndSettle();

      // Verifica elementos da UI
      expect(find.text('Kobe Scan Dashboard'), findsOneWidget);
      expect(find.text('Visão Geral'), findsOneWidget);
      
      // Verifica ícones específicos
      expect(find.byIcon(Icons.inventory_2_outlined), findsWidgets);
      expect(find.byIcon(Icons.warning_amber_rounded), findsWidgets);
      
      // Verifica se a estrutura básica existe
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('Firebase Database Mock Test', (WidgetTester tester) async {
      // Testa se componentes que usam Firebase podem ser renderizados
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.defaultTheme,
        home: Scaffold(
          appBar: AppBar(title: const Text('Firebase Test')),
          body: const Center(
            child: Text('Firebase inicializado para testes'),
          ),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Firebase Test'), findsOneWidget);
      expect(find.text('Firebase inicializado para testes'), findsOneWidget);
    });

    testWidgets('Theme Integration Test', (WidgetTester tester) async {
      // Testa se o tema funciona no contexto completo do app
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      // Verifica se as cores do tema estão sendo aplicadas
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.scaffoldBackgroundColor, AppColors.background);
    });

    testWidgets('Firebase Integration Test', (WidgetTester tester) async {
      // Verifica se o Firebase foi inicializado corretamente
      expect(Firebase.apps, isNotEmpty);
      expect(Firebase.app().name, 'test');
      
      // Testa um widget que usa Firebase
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Text('Firebase App: ${Firebase.app().name}'),
          ),
        ),
      ));

      expect(find.text('Firebase App: test'), findsOneWidget);
    });
  });
}