import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kobe_scan_app/firebase_options.dart';
import 'package:kobe_scan_app/core/app_widget.dart'; // Importa o AppWidget que criamos

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Agora, em vez do placeholder, rodamos o nosso AppWidget
  runApp(const AppWidget());
}