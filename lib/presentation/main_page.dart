import 'package:flutter/material.dart';
import 'package:kobe_scan_app/presentation/history/history_page.dart';
import 'package:kobe_scan_app/presentation/home/home_page.dart';
import 'package:kobe_scan_app/presentation/scanner/scanner_page.dart';
import 'package:kobe_scan_app/core/theme/app_theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; 

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HistoryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        backgroundColor: AppColors.primary,
        tooltip: 'Escanear código de barras', // 
        child: const Icon(Icons.qr_code_scanner, color: AppColors.background),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ---- BARRA DE NAVEGAÇÃO ----
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: AppColors.cardBackground,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // Aba Home
            IconButton(
              icon: Icon(Icons.home, 
                color: _selectedIndex == 0 ? AppColors.primary : AppColors.textSecondary,
              ),
              tooltip: 'Início', //
              onPressed: () => _onItemTapped(0),
            ),
            // Aba Histórico
            IconButton(
              icon: Icon(Icons.history, 
                color: _selectedIndex == 1 ? AppColors.primary : AppColors.textSecondary,
              ),
              tooltip: 'Histórico', // 
              onPressed: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }
}