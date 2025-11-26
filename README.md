# 📦 Kobe Scan

> Aplicativo B2B de alta performance para gerenciamento de inventário e estoque em tempo real.

![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Core-FFCA28?logo=firebase)
![Status](https://img.shields.io/badge/Status-MVP%20Concluído-success)

O **Kobe Scan** é uma solução móvel desenvolvida para resolver a desincronização de estoque entre armazéns físicos e plataformas digitais. Com foco em **acessibilidade** e **produtividade**, o app permite que funcionários escaneiem produtos, visualizem dados em tempo real e realizem ajustes de estoque instantâneos.

---

## 📱 Telas e Funcionalidades

| Dashboard & Home | Scanner Nativo | Ajuste em Tempo Real | Histórico |
|:---:|:---:|:---:|:---:|
| | | | |
| Visão geral e acesso rápido | Leitura de códigos de barras | Sincronização imediata | Log de operações |

---

## 🛠️ Tecnologias e Arquitetura

Este projeto foi desenvolvido seguindo os princípios de **Clean Architecture** e **Modularização**, garantindo escalabilidade e testabilidade.

* **Frontend:** [Flutter](https://flutter.dev/) (Dart)
* **Backend (Cloud):** [Firebase Realtime Database](https://firebase.google.com/docs/database) (NoSQL) para sincronização de baixa latência.
* **Integração Nativa:**
    * `mobile_scanner`: Utiliza **CameraX** (Android) e **AVFoundation** (iOS) para acesso direto ao hardware da câmera e **ML Kit** para visão computacional.
* **Gerenciamento de Estado:** `setState` (Otimizado para o escopo do MVP).
* **Testes:** `flutter_test` com Mock de dependências externas.

---

## ♿ Acessibilidade (Design Inclusivo)

A acessibilidade foi uma diretriz central de design, não apenas um recurso adicional.

* ✅ **Alto Contraste:** Tema escuro (`#2C2C2C`) com elementos de ação em amarelo vibrante (`#FDD835`) para máxima legibilidade em ambientes de armazém.
* ✅ **Leitores de Tela:** Todos os elementos interativos possuem `Semantics` configurados para suporte total ao **TalkBack** (Android) e **VoiceOver** (iOS).
* ✅ **Áreas de Toque:** Botões dimensionados para facilitar o uso por operadores com luvas ou dificuldades motoras.

---

## 🚀 Como Rodar o Projeto

### Pré-requisitos
* Flutter SDK instalado.
* Emulador Android ou Simulador iOS (ou dispositivo físico).
* Configuração do Firebase (arquivo `firebase_options.dart` já incluído para este projeto).

### Instalação

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/kobe-matheussilva/kobe_scan_app.git](https://github.com/kobe-matheussilva/kobe_scan_app.git)
    cd kobe_scan_app
    ```

2.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```

3.  **Configure o ambiente nativo (apenas iOS):**
    ```bash
    cd ios
    pod install --repo-update
    cd ..
    ```

4.  **Execute o aplicativo:**
    ```bash
    flutter run
    ```

---

## 🧪 Testes Automatizados

O projeto conta com testes de widget para garantir a estabilidade da interface principal (`HomePage`).

Para rodar os testes:
```bash
flutter test



📄 Estrutura de Pastas
lib/
├── core/            # Configurações globais (Tema, AppWidget)
├── presentation/    # Camada de UI (Telas e Widgets)
│   ├── adjustment/  # Tela de Ajuste de Estoque
│   ├── history/     # Tela de Histórico
│   ├── home/        # Dashboard Principal
│   ├── scanner/     # Integração Nativa com Câmera
│   └── main_page.dart # Controle de Navegação
└── main.dart        # Ponto de entrada e Inicialização do Firebase

Desenvolvido por Matheus Silva para o desafio técnico da Kobe. 🚀
