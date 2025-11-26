# Relatório Técnico: Kobe Scan

## 1. Introdução
Este documento descreve as decisões técnicas e implementações realizadas para o desenvolvimento do aplicativo **Kobe Scan**, com foco nas integrações nativas, serviços de nuvem e estratégias de acessibilidade.

## 2. Integração Nativa: Scanner de Código de Barras

### Desafio
A necessidade de ler códigos de barras diretamente pelo dispositivo exigia acesso ao hardware da câmera e processamento de imagem em tempo real, algo que o framework Flutter não faz nativamente sem pontes (channels).

### Solução Implementada
Utilizamos o pacote `mobile_scanner`, que atua como uma abstração de alto nível sobre as APIs nativas de câmera e visão computacional.

* **Android:** Utiliza a API **CameraX** do Jetpack para controle de hardware e **ML Kit** (Google) para o reconhecimento de padrões de códigos de barras.
* **iOS:** Utiliza o framework **AVFoundation** para captura de vídeo e detecção de metadados de objetos (códigos de barras/QR).

### Detalhes de Implementação
A `ScannerPage` instancia um `MobileScannerController` que gerencia o ciclo de vida da câmera. O stream de detecção (`onDetect`) processa os quadros em tempo real. Para otimizar a performance e bateria, configuramos o `detectionSpeed` para `noDuplicates` e pausamos a detecção imediatamente após a primeira leitura válida, evitando processamento desnecessário antes da navegação para a tela de ajuste.

## 3. Integração Cloud: Firebase Realtime Database

### Desafio
O aplicativo precisava de um backend rápido, com latência mínima para sincronização de estoque em "tempo real", sem a complexidade de gerenciar servidores REST tradicionais para um MVP.

### Solução Implementada
Optamos pelo **Firebase Realtime Database** (NoSQL) devido à sua capacidade de sincronização via sockets e suporte offline básico.

### Arquitetura de Dados
O banco foi estruturado em duas coleções principais para separar o estado atual do histórico de eventos:

1.  **`/estoque/{sku}`**: Armazena o estado atual do produto.
    * `nome`: String
    * `quantidade`: Inteiro
    * `ultimo_ajuste`: Timestamp ISO-8601
    * *Objetivo:* Leitura rápida na tela de Ajuste.

2.  **`/historico/{push_id}`**: Log imutável de operações.
    * `sku`: String
    * `produto`: String
    * `quantidade_ajustada`: Inteiro
    * `data`: Timestamp ISO-8601
    * *Objetivo:* Alimentar a `HistoryPage` para auditoria.

### Configuração
A inicialização ocorre no `main.dart` utilizando o `firebase_core`. As credenciais foram configuradas via `firebase_options.dart` para garantir suporte multiplataforma (Android/iOS) sem expor configurações manuais complexas nos arquivos nativos.

## 4. Acessibilidade (Diretriz de Design)

A acessibilidade não foi uma etapa pós-desenvolvimento, mas uma diretriz de design:

* **Semântica:** Utilizamos widgets `Semantics` explicitamente nos botões de incremento/decremento e nos textos de status para garantir que leitores de tela (TalkBack/VoiceOver) anunciem ações claras ("Aumentar estoque") em vez de apenas "Botão".
* **Contraste:** O tema `AppTheme` utiliza um fundo escuro (`#2C2C2C`) com elementos de ação em amarelo vibrante (`#FDD835`) e texto branco, garantindo alta legibilidade em ambientes de armazém (frequentemente com iluminação artificial ou sombras).
* **Áreas de Toque:** Botões críticos (Scanner, Salvar) possuem dimensões expandidas para facilitar o toque por usuários com luvas ou dificuldades motoras.

## 3. Integração Cloud: Firebase Realtime Database

### Desafio
O aplicativo precisava de um backend rápido, com latência mínima para sincronização de estoque em "tempo real", sem a complexidade de gerenciar servidores REST tradicionais para um MVP.

### Solução Implementada
Optamos pelo **Firebase Realtime Database** (NoSQL) devido à sua capacidade de sincronização via sockets e suporte offline básico.

### Arquitetura de Dados
O banco foi estruturado em duas coleções principais para separar o estado atual do histórico de eventos:

1.  **`/estoque/{sku}`**: Armazena o estado atual do produto.
    * `nome`: String
    * `quantidade`: Inteiro
    * `ultimo_ajuste`: Timestamp ISO-8601
    * *Objetivo:* Leitura rápida na tela de Ajuste.

2.  **`/historico/{push_id}`**: Log imutável de operações.
    * `sku`: String
    * `produto`: String
    * `quantidade_ajustada`: Inteiro
    * `data`: Timestamp ISO-8601
    * *Objetivo:* Alimentar a `HistoryPage` para auditoria.

### Configuração
A inicialização ocorre no `main.dart` utilizando o `firebase_core`. As credenciais foram configuradas via `firebase_options.dart` para garantir suporte multiplataforma (Android/iOS) sem expor configurações manuais complexas nos arquivos nativos.

## 4. Acessibilidade (Diretriz de Design)

A acessibilidade não foi uma etapa pós-desenvolvimento, mas uma diretriz de design:

* **Semântica:** Utilizamos widgets `Semantics` explicitamente nos botões de incremento/decremento e nos textos de status para garantir que leitores de tela (TalkBack/VoiceOver) anunciem ações claras ("Aumentar estoque") em vez de apenas "Botão".
* **Contraste:** O tema `AppTheme` utiliza um fundo escuro (`#2C2C2C`) com elementos de ação em amarelo vibrante (`#FDD835`) e texto branco, garantindo alta legibilidade em ambientes de armazém (frequentemente com iluminação artificial ou sombras).
* **Áreas de Toque:** Botões críticos (Scanner, Salvar) possuem dimensões expandidas para facilitar o toque por usuários com luvas ou dificuldades motoras.

## 5. Testes Automatizados

Implementamos testes de widget (`widget_test.dart`) focados na interface do usuário (UI). Utilizamos uma abordagem de **Mock** para o Firebase (`MockFirebaseCore`), permitindo que a suíte de testes valide a renderização da `HomePage` e da navegação sem depender de uma conexão de rede ativa ou credenciais reais, garantindo CI/CD estável.
>>>>>>> d8755dfd49edc8cc43b94656a14da83b4c2a4264
