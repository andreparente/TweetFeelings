# Tweets

Aplicado a arquitetura MVVM-C

Trabalho com módulos:
- Model-Protocols (são os protocolos para os modelos utilizados no aplicativo)
- Models (é a implementação dos protocolos, aqui trabalhei com Codable protocol para consumir os JSON's de resposta do backend);
- Network (para cuidar do tratamento de URLSession, HttpHeaders e afins);
- Service (para cada feature/flow, camada fica responsável por fazer os requests e tratar o retorno);
- ViewModel (fica responsável pelas regras de negócio, cada viewModel tem seu serviço, e ela faz todos os tratamentos necessários conforme regras de negócio e só expõe o que for necessário para a camada da view)
- ViewController (lifecycle de cada tela);
- View (usando aqui o design pattern view-code para uma maior manutenabilidade e para evitar de trabalhar com arquivos .xib em equipe e evitar conflitos complicados).

Tento sempre utilizar protocol-oriented programming para facilitar o entendimento, a reusabilidade, modularização e testabilidade do sistema.

Para os testes, trabalhei em cima do snapshotTesting (lib terceira para testes de UI), e testes unitários na camada da ViewModel. Mockando todos os modelos e serviços.

quaisquer dúvidas favor abrir Issue.
