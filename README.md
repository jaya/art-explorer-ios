# Art Explorer iOS

## Desafio iOS com The Met Museum API

### Sobre

Aplicativo iOS em Swift para explorar obras de arte do Metropolitan Museum of Art (The Met), utilizando sua API aberta.
Permite listar obras com imagens, ver detalhes, e favoritar obras.

### Imagens
![Simulator Screenshot - iPhone 16 - 2025-06-09 at 21 34 35](https://github.com/user-attachments/assets/78a74dbd-1a1a-4455-8a89-725085817614)
![Simulator Screenshot - iPhone 16 - 2025-06-09 at 21 34 39](https://github.com/user-attachments/assets/abdbc14d-9e22-4772-ac68-ad0c15ac7c50)

### Funcionalidades implementadas

* Listagem de obras com imagens (15 por página)
* Visualização de detalhes (título, artista, data, técnica, imagem, créditos)
* Marcar e desmarcar favoritos com persistência local
* Interface simples e responsiva em SwiftUI

### Como rodar o projeto

* Abra o projeto no Xcode 16.4 (ou superior)
* Rode no simulador ou dispositivo iOS 18.5+
* O app já busca as obras via API pública do The Met

### Decisões arquiteturais

* Arquitetura MVVM usando SwiftUI
* Uso de @StateObject para gerenciamento de estado
* Persistência local com SwiftData
* Uso de KFImage para carregamento assíncrono e cache de imagens

### Endpoints utilizados

* Buscar obras com imagem:
GET `/public/collection/v1/search?hasImages=true&q=painting`
* Buscar detalhes da obra:
GET `/public/collection/v1/objects/{objectID}`

### Licença

Os dados são fornecidos pela **The Met Museum Open Access API** sob licença [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/).

### Contato

* Autor: Rafael Almeida
* Email: [apprafael.almeida@gmail.com](mailto:apprafael.almeida@gmail.com)
