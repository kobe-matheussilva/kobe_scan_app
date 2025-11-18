import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usando o AppBar que definimos no nosso tema
      appBar: AppBar(
        title: const Text('Kobe Scan'), 
      ),
      body: const Center(
        child: Text('Home Page (Dashboard)'),
      ),
    );
  }
}