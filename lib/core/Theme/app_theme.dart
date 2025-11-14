import 'package:flutter/material.dart';

// Definindo as cores do nosso app para facilitar o uso
class AppColors {
  static const Color primary = Color(0xFFFDD835); // Amarelo (para botões, destaque)
  static const Color background = Color(0xFF2C2C2C); // Cinza escuro (fundo geral)
  static const Color text = Color(0xFFFFFFFF); // Branco (para texto principal)
  static const Color textSecondary = Color(0xFFB0B0B0); // Cinza claro (para texto secundário)
  static const Color cardBackground = Color(0xFF424242); // Cinza médio (para cards, inputs)
  static const Color success = Color(0xFF4CAF50); // Verde (para indicações de sucesso)
  static const Color error = Color(0xFFF44336); // Vermelho (para indicações de erro)
}

class AppTheme {
  static final ThemeData defaultTheme = ThemeData(
    brightness: Brightness.dark, // Define o tema como "dark mode"
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    hintColor: AppColors.textSecondary, // Cor para textos de dica (placeholders)

    // Estilo padrão para a AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.text, // Cor do título e ícones na AppBar
      elevation: 0, // Sem sombra na AppBar
      centerTitle: true,
    ),

    // Estilos padrão para diferentes tamanhos de texto
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: AppColors.text, fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: AppColors.text, fontSize: 24, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: AppColors.text, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.text, fontSize: 14),
      bodySmall: TextStyle(color: AppColors.textSecondary, fontSize: 12),
      labelLarge: TextStyle(color: AppColors.background, fontSize: 16, fontWeight: FontWeight.bold), // Estilo para texto de botões primários
    ),

    // Estilo padrão para botões elevados (ElevatedButton)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary, // Cor de fundo do botão
        foregroundColor: AppColors.background, // Cor do texto do botão
        minimumSize: const Size(double.infinity, 50), // Botões full width e altura mínima
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Borda arredondada
        ),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),

    // Estilo padrão para campos de input (TextFormField, TextField)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardBackground, // Fundo dos campos de input
      hintStyle: const TextStyle(color: AppColors.textSecondary),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none, // Sem borda externa padrão
      ),
      enabledBorder: OutlineInputBorder( // Borda quando o campo não está focado
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder( // Borda quando o campo está focado
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary, width: 2), // Borda amarela ao focar
      ),
    ),

    // Estilo padrão para cards
    cardTheme: CardThemeData(
      color: AppColors.cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),

    // Estilo padrão para a BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.cardBackground,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedLabelStyle: TextStyle(fontSize: 12),
    ),
  );
}