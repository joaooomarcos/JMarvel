# JMarvel

[![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg?style=for-the-badge)](https://www.apple.com/br/ios/ios-12/)
[![Compatibility](https://img.shields.io/badge/Compatibility-iPhone|iPad%20-lightgrey.svg?style=for-the-badge)](https://www.apple.com/br/iphone/)

[![Platform](https://img.shields.io/badge/iOS_Version-13.0+-green.svg?style=for-the-badge)](https://www.apple.com/br/ios/ios-12/)
[![Swift Version](https://img.shields.io/badge/swift-5.0-orange.svg?style=for-the-badge)](https://swift.org/)
[![XCode Version](https://img.shields.io/badge/Xcode_Version-11.0+-blue.svg?style=for-the-badge)](https://developer.apple.com/xcode/)

## Bem vindo

Projeto de teste baseado na API de personagens da Marvel

### Principais Funcionalidades
- Listagem de personagens ordenados por nome
- Listagem de personagens favoritos
- Detalhe do personagem (imagem maior, nome, descrição, carossel de series e hqs)
- Widget com os três primeiros personagens favoritos

### Recursos disponíveis
- Pull to refresh na listagem de personagens
- Filtro por nome na listagem de personagens
- Scroll "infinito" (ao chegar perto do final da página, são carregados mais itens)
- Ação de favoritar personagem dentro e fora do detalhe
- Dark mode
- Shortcuts

### Desenvolvimento

#### Arquitetura
VIPER

#### Bibliotecas Utilizadas 
- `KingFisher` (baixar imagens e cachear)
- `RealmSwift` (banco de dados local)
- `SwiftLint` (aprimorar o padrão de código)
- `Quick` (testes unitários)
- `Nimble` (testes unitários)

** Todas bibliotecas utilizadas com o `CocoaPods`

#### Como executar o projeto a primeira vez
O projeto utiliza o `Bundler` para gerenciamento de versão das ferramentas, então é necessário ter instaldo:
```shell
sudo gem install bundler
```
Depois instale os componentes do `Bundler` (dentro da pasta do projeto):
```shell
bundle install
```
Por fim basta instalar o `Pods` na sua máquina:
```shell
bundle exec pod install
```

#### Testes unitários
Os testes unitários podem ser executados tanto pelo próprio Xcode, tanto pelo `Fastlane`.

Para executar via `Fastlane`:
```shell
bundle exec fastlane unit_tests
```