/// Acertos mínimos no quiz para ganhar a medalha "Cientista".
const int notaParaMedalha = 4;

class Pergunta {
  final String enunciado;
  final List<String> opcoes;
  final int correta; // índice da opção certa (começa em 0)
  final String explicacao;
  const Pergunta({required this.enunciado, required this.opcoes, required this.correta, required this.explicacao});
}

const perguntas = [
  Pergunta(
    enunciado: 'Mito ou verdade: tecnologia nuclear serve só para bombas e usinas.',
    opcoes: ['Verdade', 'Mito'], correta: 1,
    explicacao: 'Mito! Ela também está na saúde, agricultura, indústria e pesquisa.',
  ),
  Pergunta(
    enunciado: 'Qual radioisótopo é muito usado em exames de medicina nuclear?',
    opcoes: ['Tecnécio-99m', 'Hélio-4', 'Ferro-56'], correta: 0,
    explicacao: 'O tecnécio-99m é usado em diversos exames de imagem.',
  ),
  Pergunta(
    enunciado: 'A técnica do inseto estéril serve para…',
    opcoes: ['Gerar energia', 'Controlar pragas', 'Datar fósseis'], correta: 1,
    explicacao: 'Machos estéreis reduzem a reprodução da praga.',
  ),
  Pergunta(
    enunciado: 'Uma usina nuclear emite CO₂ ao gerar eletricidade?',
    opcoes: ['Sim, muito', 'Não na geração da energia', 'Só à noite'], correta: 1,
    explicacao: 'A fissão não queima combustível, então não emite CO₂ na geração.',
  ),
  Pergunta(
    enunciado: 'O carbono-14 é usado para…',
    opcoes: ['Datar materiais orgânicos antigos', 'Esterilizar água', 'Medir terremotos'], correta: 0,
    explicacao: 'Ele funciona como um relógio natural para restos orgânicos.',
  ),
];
