import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:kobe_scan_app/presentation/adjustment/adjustment_page.dart';
import 'package:kobe_scan_app/core/theme/app_theme.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  // Controlador da câmera para gerenciar o flash, troca de câmera, etc.
  MobileScannerController? controller;
  
  bool _isScanning = true; // Para evitar navegação dupla
  bool _isInitialized = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeScanner();
  }

  void _initializeScanner() async {
    try {
      controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        returnImage: false,
      );
      
      setState(() {
        _isInitialized = true;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao inicializar câmera: $e';
        _isInitialized = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar flutuante sobre a câmera para ficar bonito
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Escanear Código'),
        backgroundColor: Colors.black45, // Semi-transparente
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Botão de Flash simplificado
          IconButton(
            icon: const Icon(Icons.flash_on, color: Colors.white),
            onPressed: () => controller?.toggleTorch(),
          ),
        ],
      ),
      body: _errorMessage != null 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _initializeScanner,
                  child: const Text('Tentar Novamente'),
                ),
              ],
            ),
          )
        : !_isInitialized || controller == null
        ? const Center(child: CircularProgressIndicator())
        : Stack(
        children: [
          // 1. A Câmera em si
          MobileScanner(
            controller: controller!,
            onDetect: (capture) {
              if (!_isScanning) return; // Se já leu, ignora

              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  final String code = barcode.rawValue!;
                  
                  setState(() {
                    _isScanning = false; // Trava novas leituras
                  });

                  debugPrint('Código lido: $code');

                  // Navega para a tela de ajuste passando o código
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdjustmentPage(scannedSku: code),
                    ),
                  ).then((_) {
                    // Se voltar da tela de ajuste, reativa o scanner (opcional, pois usamos pushReplacement)
                     _isScanning = true;
                  });
                  
                  break; // Lê apenas o primeiro código encontrado
                }
              }
            },
          ),

          // 2. O Overlay (A mira quadrada e o escurecimento em volta)
          // Vamos fazer um overlay simples usando ColorFiltered ou Containers
          // Para simplificar, vamos usar um Container com borda decorativa no centro
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 3), // Borda amarela
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Apenas para decoração visual
                ],
              ),
            ),
          ),
          
          // 3. Texto de instrução na parte inferior
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Aponte a câmera para o código de barras',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}