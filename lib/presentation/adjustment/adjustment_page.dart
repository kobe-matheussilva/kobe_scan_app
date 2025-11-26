import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kobe_scan_app/core/theme/app_theme.dart';

class AdjustmentPage extends StatefulWidget {
  final String? scannedSku;

  const AdjustmentPage({super.key, this.scannedSku});

  @override
  State<AdjustmentPage> createState() => _AdjustmentPageState();
}

class _AdjustmentPageState extends State<AdjustmentPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  
  int _currentStock = 0;
  bool _isLoading = true;
  String _productName = "Carregando...";

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  Future<void> _loadProductData() async {
    final sku = widget.scannedSku ?? 'unknown';
    try {
      final snapshot = await _database.child('estoque/$sku').get().timeout(const Duration(seconds: 10));
      if (snapshot.exists) {
        final data = snapshot.value as Map?;
        setState(() {
          _currentStock = (data?['quantidade'] ?? 0) as int;
          _productName = (data?['nome'] ?? 'Produto Desconhecido') as String;
          _isLoading = false;
        });
      } else {
        setState(() {
          _productName = "Novo Produto ($sku)";
          _currentStock = 0;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _productName = "Produto ($sku) - Offline";
        _currentStock = 0;
        _isLoading = false;
      });
    }
  }

  Future<void> _saveStock() async {
    final sku = widget.scannedSku ?? 'unknown';
    final timestamp = DateTime.now().toIso8601String();
    setState(() => _isLoading = true);

    try {
      await _database.child('estoque/$sku').set({
        'nome': _productName,
        'quantidade': _currentStock,
        'ultimo_ajuste': timestamp,
      }).timeout(const Duration(seconds: 10));

      await _database.child('historico').push().set({
        'sku': sku,
        'produto': _productName,
        'quantidade_ajustada': _currentStock,
        'data': timestamp,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Estoque e Histórico atualizados!'), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Salvo localmente (Offline)'), backgroundColor: Colors.orange),
        );
        Navigator.pop(context);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _increment() => setState(() => _currentStock++);
  void _decrement() {
    if (_currentStock > 0) setState(() => _currentStock--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajuste de Estoque'), centerTitle: true),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.inventory, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        // CORREÇÃO 1: MergeSemantics para ler o card como um bloco único e coerente
                        MergeSemantics(
                          child: Column(
                            children: [
                              Text(
                                _productName,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'SKU: ${widget.scannedSku}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Controles de Estoque
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // CORREÇÃO 2: Passando o label direto para o botão
                      _buildCircleButton(
                        icon: Icons.remove,
                        onPressed: _decrement,
                        label: "Diminuir estoque", 
                      ),
                      
                      const SizedBox(width: 32),
                      
                      // CORREÇÃO 3: excludeSemantics true para não ler o número duas vezes
                      Semantics(
                        label: "Estoque atual",
                        value: "$_currentStock itens",
                        excludeSemantics: true, 
                        child: Text(
                          '$_currentStock',
                          style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                      ),
                      
                      const SizedBox(width: 32),
                      
                      // CORREÇÃO 2: Passando o label direto para o botão
                      _buildCircleButton(
                        icon: Icons.add,
                        onPressed: _increment,
                        label: "Aumentar estoque",
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _saveStock,
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                      child: const Text('SALVAR AJUSTE', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  // CORREÇÃO FINAL: O Helper agora aceita 'label' e usa 'tooltip'
  Widget _buildCircleButton({
    required IconData icon, 
    required VoidCallback onPressed, 
    required String label
  }) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
        tooltip: label, // O leitor de tela lê isso aqui!
      ),
    );
  }
}