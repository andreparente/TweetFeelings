# TweetFeelings

Aplicado a arquitetura a qual tenho mais familiaridade: MVVM.

Trabalho com módulos:
- Network (para cuidar do tratamento de URLSession, HttpHeaders e afins);
- Service (para cada feature/flow, camada fica responsável por fazer os requests e tratar o retorno);
- ViewModel (fica responsável pelas regras de negócio, cada viewModel tem seu serviço, e ela faz todos os tratamentos necessários conforme regras de negócio)
- ViewController;
- View (usando aqui o view-codable para uma maior manutabilidade 
