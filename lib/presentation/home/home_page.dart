import 'package:flutter/material.dart';
import 'package:kobe_scan_app/core/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kobe Scan Dashboard'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent, // Deixa o fundo da AppBar transparente para bater com o design
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título da Seção
            Text(
              'Visão Geral',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),

            // Cards de Resumo (Linha Superior)
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: 'Total Itens',
                    value: '1,240', // Valor mockado
                    subtitle: 'Total Itens', // Texto pequeno abaixo do número
                    icon: Icons.inventory_2_outlined, // Ícone de caixa
                    iconColor: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: 'Críticos',
                    value: '15', // Valor mockado
                    subtitle: 'Críticos',
                    icon: Icons.warning_amber_rounded, // Ícone de alerta
                    iconColor: AppColors.error, // Usando a cor que você adicionou
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Título da Seção
            Text(
              'Último Item Escaneado',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),

            // Card do Último Item (Estilo Dark/Cinza do seu print)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Ícone quadrado
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.layers_clear, color: Colors.grey), // Ícone genérico
                  ),
                  const SizedBox(width: 16),

                  // Textos (Nome e SKU)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Camiseta Básica Preta',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'SKU: 89302910',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quantidade (Qtd 50)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Qtd', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(
                        '50',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.primary, // Amarelo
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),
            // Texto de instrução centralizado
            Center(
              child: Text(
                'Toque no botão + para escanear',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper para os Cards de Cima (Total e Críticos)
  Widget _buildSummaryCard(BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}