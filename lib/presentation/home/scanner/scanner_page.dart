import 'package:flutter/material.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Item'),
      ),
      body: const Center(
        child: Text('Scanner Page (Câmera)'),
      ),
    );
  }
}