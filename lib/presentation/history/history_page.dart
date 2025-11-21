import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kobe_scan_app/core/theme/app_theme.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseReference database = FirebaseDatabase.instance.ref().child('historico');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Scans'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: database.orderByChild('data').onValue, // Ouve mudanças em tempo real
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          // 1. Estado de Carregamento
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          // 2. Estado de Erro
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar histórico: ${snapshot.error}'));
          }

          // 3. Estado Sem Dados
          if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.history, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum histórico encontrado',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          }

          // 4. Processamento dos Dados para Lista
          // O Firebase retorna um Map, precisamos converter para Lista e inverter (mais recente primeiro)
          Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          List<Map<String, dynamic>> historyList = [];

          data.forEach((key, value) {
            historyList.add({
              'id': key,
              ...Map<String, dynamic>.from(value)
            });
          });

          // Ordena por data (decrescente - mais recente no topo)
          historyList.sort((a, b) => (b['data'] as String).compareTo(a['data'] as String));

          // 5. Exibição da Lista
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              final item = historyList[index];
              final DateTime date = DateTime.parse(item['data']);
              final String dateString = "${date.day}/${date.month} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[800],
                    child: const Icon(Icons.qr_code, color: Colors.white),
                  ),
                  title: Text(
                    item['produto'] ?? 'Produto Desconhecido',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SKU: ${item['sku']}', style: const TextStyle(color: Colors.grey)),
                      Text(dateString, style: TextStyle(color: AppColors.primary, fontSize: 12)),
                    ],
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Text(
                      '${item['quantidade_ajustada']}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}