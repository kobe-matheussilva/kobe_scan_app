import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Scans'),
      ),
      body: const Center(
        child: Text('History Page (Lista de Scans)'),
      ),
    );
  }
}