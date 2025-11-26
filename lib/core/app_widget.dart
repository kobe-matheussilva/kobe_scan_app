import 'package:flutter/material.dart';
import 'package:kobe_scan_app/core/theme/app_theme.dart';

// Importando a página principal com a navegação
import 'package:kobe_scan_app/presentation/main_page.dart'; 

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kobe Scan',
      debugShowCheckedModeBanner: false, // Remove a faixa de "debug"
      theme: AppTheme.defaultTheme, // Aplica tema personalizado

      // Esta será a tela que controla a BottomNavigationBar
      home: const MainPage(), 
    );
  }
}