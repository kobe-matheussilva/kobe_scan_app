import 'package:flutter/material.dart';
import 'package:kobe_scan_app/core/Theme/app_theme.dart'; // Para usar as cores e estilos definidos

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Chave para validar o formulário

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Lógica de autenticação com Firebase Auth virá aqui
      // Por enquanto, apenas printa os valores
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      // Navegar para a Home Page (ainda não existe)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView( // Permite rolar a tela se o teclado aparecer
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                Image.asset(
                  'assets/logo_kobe_scan.png', // Precisamos adicionar este asset
                  height: 120,
                ),
                const SizedBox(height: 16),
                Text(
                  'KOBE SCAN',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.text),
                ),
                const SizedBox(height: 32),
                Text(
                  'Acesso Restrito',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.text),
                ),
                const SizedBox(height: 32),

                // Campo de E-mail
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email, color: AppColors.textSecondary),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu email';
                    }
                    if (!value.contains('@')) {
                      return 'Email inválido';
                    }
                    return null;
                  },
                  style: const TextStyle(color: AppColors.text), // Cor do texto digitado
                ),
                const SizedBox(height: 16),

                // Campo de Senha
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Senha',
                    prefixIcon: Icon(Icons.lock, color: AppColors.textSecondary),
                  ),
                  obscureText: true, // Esconde o texto da senha
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                  style: const TextStyle(color: AppColors.text), // Cor do texto digitado
                ),
                const SizedBox(height: 32),

                // Botão Entrar
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Entrar'),
                ),

                // Links secundários (Opcional)
                // const SizedBox(height: 24),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     TextButton(
                //       onPressed: () { /* Navegar para tela de recuperação */ },
                //       child: Text('Problemas para entrar?', style: Theme.of(context).textTheme.bodySmall),
                //     ),
                //     TextButton(
                //       onPressed: () { /* Navegar para tela de solicitação de acesso */ },
                //       child: Text('Solicitar acesso', style: Theme.of(context).textTheme.bodySmall),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}