# TweetFeelings

Aplicado a arquitetura MVVM.
(Não implementei coordinator pattern por ser um projeto de apenas uma tela)

Trabalho com módulos:
- Model-Protocols (são os protocolos para os modelos utilizados no aplicativo)
- Models (é a implementação dos protocolos);
- Network (para cuidar do tratamento de URLSession, HttpHeaders e afins);
- Service (para cada feature/flow, camada fica responsável por fazer os requests e tratar o retorno);
- ViewModel (fica responsável pelas regras de negócio, cada viewModel tem seu serviço, e ela faz todos os tratamentos necessários conforme regras de negócio)
- ViewController;
- View (usando aqui o design pattern view-code para uma maior manutenabilidade e para evitar de trabalhar com arquivos .xib em equipe e evitar conflitos complicados).

Tento sempre utilizar protocol-oriented programming para facilitar o entendimento, a reusabilidade, modularização e testabilidade do sistema.

Para os testes, trabalhei em cima do snapshotTesting (lib terceira para testes de UI), e testes unitários na camada da ViewModel. Mockando todos os modelos e serviços.

quaisquer dúvidas favor abrir Issue.
