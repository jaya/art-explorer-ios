# 🖼️ ArtExplorer

ArtExplorer é um aplicativo iOS desenvolvido com SwiftUI que permite explorar obras de arte do [Metropolitan Museum of Art API](https://metmuseum.github.io/). Os usuários podem visualizar detalhes, favoritar obras e alternar entre a lista completa e seus favoritos.

## 📦 Funcionalidades

- Listagem de obras com carregamento progressivo (infinite scroll)
- Visualização detalhada de cada obra
- Favoritar e desfavoritar obras
- Alternar entre lista completa e favoritos
- Mensagens de erro e feedback visual de carregamento

## 🧱 Arquitetura

O projeto segue a arquitetura **MVVM-C (Model–View–ViewModel–Coordinator)** com injeção de dependências usando o [Resolver](https://github.com/hmlongco/Resolver).

### Estrutura

```plaintext
ArtExplorer
├── App/                     # App entry point, Coordinator, injeção de dependências
├── Models/                  # Modelos de dados (ArtObject, etc.)
├── Services/                # Serviços de rede, cache e favoritos
│   ├── ArtService.swift         # Responsável por buscar dados da API do Met Museum
│   ├── FavoritesService.swift   # Gerencia o sistema de favoritos com persistência local
│   └── Protocols/               # Protocolos usados para facilitar testes e injeção de dependência
├── ViewModels/              # ViewModels das telas
├── Views/                   # Telas em SwiftUI agrupadas por contexto
├── Resources/               # Assets e recursos auxiliares
├── ArtExplorerTests/        # Testes de unidade
├── ArtExplorerUITests/      # Testes de interface (UI tests)
```

## 🧪 Testes

O projeto possui testes automatizados cobrindo ViewModels e interações de interface:

### ✅ Testes de Unidade

- `ArtListViewModelTests`
- `ArtDetailViewModelTests`
- `FavoritesServiceTests`

### 📲 Testes de Interface (UI Tests)

- Teste de listagem inicial
- Teste de alternância entre favoritos e lista geral
- Teste de abertura e funcionamento da tela de detalhes
- Teste da funcionalidade de favoritar e desfavoritar
- Teste de mensagem de erro e botão de tentativa

## ▶️ Execução

1. Clone o repositório:

```bash
git clone https://github.com/seu-usuario/ArtExplorer.git
```

2. Abra o projeto no Xcode:

```bash
open ArtExplorer.xcodeproj
```

3. Rode o projeto com `Cmd + R`.

## 🧪 Execução dos testes

Para rodar os testes unitários e de UI:

```bash
Cmd + U
```

Para ativar mocks de testes, o app usa o argumento `--uitesting` em `launchArguments`.

## 🛠 Tecnologias

- Swift 5.9+
- SwiftUI
- Combine
- Resolver
- XCTest / XCUITest
