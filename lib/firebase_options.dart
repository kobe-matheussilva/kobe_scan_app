// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'Windows not configured.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'Linux not configured.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // --- PREENCHA AQUI COM OS DADOS DO CONSOLE FIREBASE ---
  
  // Você acha o URL na aba "Realtime Database". Ex: https://kobescanapp-default-rtdb.firebaseio.com
  static const String myDatabaseUrl = 'https://kobescanapp-dbb1c-default-rtdb.firebaseio.com'; 
  static const String myProjectId = 'kobescanapp';
  static const String myMessagingSenderId = '884519809250';
  static const String myStorageBucket = 'kobescanapp.appspot.com';

  // --- WEB ---
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'PREENCHA_API_KEY_WEB',
    appId: 'PREENCHA_APP_ID_WEB',
    messagingSenderId: myMessagingSenderId,
    projectId: myProjectId,
    databaseURL: myDatabaseUrl, // <--- IMPORTANTE
    storageBucket: myStorageBucket,
  );

  // --- ANDROID ---
  // Vá em Configurações do Projeto > Seus Apps > Selecione o Android > Copie a API Key e App ID
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'COPIE_A_API_KEY_DO_ANDROID_AQUI', 
    appId: 'COPIE_O_APP_ID_DO_ANDROID_AQUI', 
    messagingSenderId: myMessagingSenderId,
    projectId: myProjectId,
    databaseURL: myDatabaseUrl, // <--- IMPORTANTE: Isso estava faltando!
    storageBucket: myStorageBucket,
  );

  // --- iOS ---
  // Vá em Configurações do Projeto > Seus Apps > Selecione o iOS > Copie a API Key e App ID
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTUlecMEE8GPgPC6Np7U9j02PuBvK-Qkc',
    appId: '1:884519809250:ios:67b002cfa1e1e37bf2eebb',
    messagingSenderId: myMessagingSenderId,
    projectId: myProjectId,
    databaseURL: 'https://kobescanapp-dbb1c-default-rtdb.firebaseio.com', // <--- IMPORTANTE: Isso estava faltando!
    storageBucket: myStorageBucket,
    iosBundleId: 'com.example.kobeScanApp', // Confirme se é esse mesmo Bundle ID no Xcode
  );

  // --- MacOS (Pode repetir o iOS se não for usar, ou ignorar) ---
  static const FirebaseOptions macos = ios;
}