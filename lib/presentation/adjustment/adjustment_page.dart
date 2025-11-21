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
  // Referência ao banco de dados
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  
  int _currentStock = 0;
  bool _isLoading = true;
  String _productName = "Carregando...";

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  // Função para buscar dados no Firebase
  Future<void> _loadProductData() async {
    final sku = widget.scannedSku ?? 'unknown';
    
    try {
      // Timeout para evitar carregamento infinito
      final snapshot = await _database
          .child('estoque/$sku')
          .get()
          .timeout(const Duration(seconds: 10));

      if (snapshot.exists) {
        final data = snapshot.value as Map?;
        setState(() {
          _currentStock = (data?['quantidade'] ?? 0) as int;
          _productName = (data?['nome'] ?? 'Produto Desconhecido') as String;
          _isLoading = false;
        });
      } else {
        // Se o produto não existe no banco, iniciamos com 0
        setState(() {
          _productName = "Novo Produto ($sku)";
          _currentStock = 0;
          _isLoading = false;
        });
      }
    } catch (e) {
      // Em caso de erro (timeout, sem internet, Firebase down), usa dados offline
      print('Erro ao carregar dados do Firebase: $e');
      setState(() {
        _productName = "Produto ($sku) - Offline";
        _currentStock = 0;
        _isLoading = false;
      });
      
      // Mostra um aviso ao usuário
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Modo offline - dados não sincronizados'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  // Função para salvar no Firebase (ALTERADA PARA SALVAR HISTÓRICO)
  Future<void> _saveStock() async {
    final sku = widget.scannedSku ?? 'unknown';
    final timestamp = DateTime.now().toIso8601String();
    
    setState(() => _isLoading = true);

    try {
      // 1. Atualiza o Estoque Atual (Como já fazia antes)
      await _database
          .child('estoque/$sku')
          .set({
            'nome': _productName,
            'quantidade': _currentStock,
            'ultimo_ajuste': timestamp,
          })
          .timeout(const Duration(seconds: 10));

      // 2. NOVO: Salva um registro no Histórico
      // Usamos .push() para criar um ID único para cada evento
      await _database.child('historico').push().set({
        'sku': sku,
        'produto': _productName,
        'quantidade_ajustada': _currentStock,
        'data': timestamp,
        // Você pode adicionar quem fez o ajuste aqui se tivéssemos login
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Estoque e Histórico atualizados com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Volta para a tela anterior
      }
    } catch (e) {
      print('Erro ao salvar no Firebase: $e');
      if (mounted) {
        // Simula salvamento offline
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao salvar online. Verifique sua conexão.'),
            backgroundColor: Colors.red, // Mudei para vermelho para indicar erro real
          ),
        );
        Navigator.pop(context);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _increment() {
    setState(() => _currentStock++);
  }

  void _decrement() {
    if (_currentStock > 0) {
      setState(() => _currentStock--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuste de Estoque'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: AppColors.primary),
                  const SizedBox(height: 16),
                  const Text('Salvando dados...'),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Card do Produto
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
                        Text(
                          _productName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                          semanticsLabel: "Produto: $_productName", 
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'SKU: ${widget.scannedSku}',
                          style: Theme.of(context).textTheme.bodyMedium,
                          semanticsLabel: "Código SKU: ${widget.scannedSku}",
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),

                  // Controles de Estoque
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Botão Menos
                      Semantics(
                        label: "Diminuir estoque",
                        button: true,
                        child: _buildCircleButton(
                          icon: Icons.remove,
                          onPressed: _decrement,
                        ),
                      ),
                      
                      const SizedBox(width: 32),
                      
                      // Mostrador de Quantidade
                      Semantics(
                        label: "Estoque atual",
                        value: "$_currentStock itens",
                        child: Text(
                          '$_currentStock',
                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 32),
                      
                      // Botão Mais
                      Semantics(
                        label: "Aumentar estoque",
                        button: true,
                        child: _buildCircleButton(
                          icon: Icons.add,
                          onPressed: _increment,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Botão Salvar
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _saveStock,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text(
                        'SALVAR AJUSTE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _buildCircleButton({required IconData icon, required VoidCallback onPressed}) {
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
      ),
    );
  }
}