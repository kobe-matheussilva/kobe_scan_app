import 'package:flutter/material.dart';
import 'package:kobe_scan_app/presentation/history/history_page.dart';
import 'package:kobe_scan_app/presentation/home/home_page.dart';
import 'package:kobe_scan_app/presentation/scanner/scanner_page.dart';
import 'package:kobe_scan_app/core/theme/app_theme.dart'; // Importa nossas cores

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; 

  // AGORA TEMOS APENAS 2 TELAS NAS ABAS
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HistoryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Função para navegar para a tela do Scanner
  void _navigateToScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScannerPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      // ---- BOTÃO FLUTUANTE (FAB) ----
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToScanner,
        backgroundColor: AppColors.primary, // Nossa cor amarela
        child: const Icon(Icons.qr_code_scanner, color: AppColors.background),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Centraliza o FAB

      // ---- BARRA DE NAVEGAÇÃO COM 2 ABAS ----
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // Faz o "corte" para o FAB
        notchMargin: 6.0,
        color: AppColors.cardBackground, // Cor da barra
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // Aba Home
            IconButton(
              icon: Icon(Icons.home, 
                color: _selectedIndex == 0 ? AppColors.primary : AppColors.textSecondary,
              ),
              onPressed: () => _onItemTapped(0),
            ),
            // Aba Histórico
            IconButton(
              icon: Icon(Icons.history, 
                color: _selectedIndex == 1 ? AppColors.primary : AppColors.textSecondary,
              ),
              onPressed: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }
}