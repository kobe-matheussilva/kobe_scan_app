import 'package:flutter/material.dart';
import 'package:kobe_scan_app/presentation/history/history_page.dart';
import 'package:kobe_scan_app/presentation/home/home_page.dart';
import 'package:kobe_scan_app/presentation/scanner/scanner_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Controla qual aba está selecionada
  int _selectedIndex = 0; 

  // Lista das 3 telas que criamos (os placeholders)
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const ScannerPage(),
    const HistoryPage(),
  ];

  // Função chamada quando o usuário toca em uma aba
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O corpo da tela será a tela selecionada da nossa lista
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      // A barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Escanear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
        ],
        currentIndex: _selectedIndex, // Aba atual
        onTap: _onItemTapped, // O que fazer ao tocar
        // Os estilos (cores, etc.) já vêm do nosso AppTheme!
      ),
    );
  }
}