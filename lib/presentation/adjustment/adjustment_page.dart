import 'package:flutter/material.dart';

class AdjustmentPage extends StatelessWidget {
  final String? scannedSku; // Para receber o SKU escaneado

  // O construtor recebe o SKU
  const AdjustmentPage({super.key, this.scannedSku});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // O AppBar aqui terá automaticamente um botão "Voltar"
        title: const Text('Ajuste de Estoque'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SKU Escaneado:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              scannedSku ?? 'Nenhum SKU lido', // Mostra o SKU
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            const Text(
              '(Aqui virão os campos de Estoque Atual, botões +/-, e Salvar)',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}