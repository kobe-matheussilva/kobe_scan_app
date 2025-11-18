import 'package:flutter/material.dart';
import 'package:kobe_scan_app/core/Theme/app_theme.dart';
import 'package:kobe_scan_app/presentation/auth/login_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kobe Scan',
      debugShowCheckedModeBanner: false, // Remove a faixa de "debug"
      theme: AppTheme.defaultTheme, // Aplica nosso tema personalizado
      home: const LoginPage(), // Tela de login
    );
  }
}

// Tela temporária para testar o tema
class TemporaryHomePage extends StatelessWidget {
  const TemporaryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kobe Scan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Bem-vindo ao Kobe Scan!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Tema configurado com sucesso',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Botão de Teste'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Campo de teste',
              ),
            ),
          ],
        ),
      ),
    );
  }
}