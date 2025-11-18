import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';     // Importa o Firebase Core
import 'package:kobe_scan_app/firebase_options.dart';  // Importa o arquivo que você gerou

void main() async {
  // Garante que o Flutter está pronto para o Firebase
  WidgetsFlutterBinding.ensureInitialized(); 

  // Inicializa o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Roda um app temporário SÓ PARA TESTAR
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: Text(
          'Firebase Inicializado com Sucesso!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      backgroundColor: Color(0xFF2C2C2C), // Nosso fundo escuro
    ),
  ));
}