import 'package:flutter/material.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF2C2C2C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.qr_code_scanner,
              size: 120,
              color: Color(0xFFFDD835),
            ),
            const SizedBox(height: 32),
            const Text(
              'Scanner QR Code',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Funcionalidade do scanner será implementada aqui',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // Aqui será implementada a funcionalidade do scanner
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Scanner será implementado em breve!'),
                    backgroundColor: Color(0xFFFDD835),
                  ),
                );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Iniciar Scanner'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFDD835),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
