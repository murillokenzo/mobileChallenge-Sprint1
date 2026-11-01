const int notaParaMedalha = 8;

class Pergunta {
  final String enunciado;
  final List<String> opcoes;
  final int correta; 
  final String explicacao;
  final String categoriaId; 
  const Pergunta({
    required this.enunciado,
    required this.opcoes,
    required this.correta,
    required this.explicacao,
    this.categoriaId = 'geral',
  });
}

const perguntas = [
  Pergunta(
    enunciado: 'Mito ou verdade: tecnologia nuclear serve só para bombas e usinas.',
    opcoes: ['Verdade', 'Mito'], correta: 1,
    explicacao: 'Mito! Ela também está na saúde, agricultura, indústria e pesquisa.',
  ),
  Pergunta(
    categoriaId: 'saude',
    enunciado: 'Qual radioisótopo é muito usado em exames de medicina nuclear?',
    opcoes: ['Tecnécio-99m', 'Hélio-4', 'Ferro-56'], correta: 0,
    explicacao: 'O tecnécio-99m é usado em diversos exames de imagem.',
  ),
  Pergunta(
    categoriaId: 'saude',
    enunciado: 'A radioterapia usa radiação para…',
    opcoes: ['Tratar tumores', 'Esterilizar alimentos', 'Gerar vapor'], correta: 0,
    explicacao: 'A radiação é direcionada para destruir células tumorais.',
  ),
  Pergunta(
    categoriaId: 'energia',
    enunciado: 'Uma usina nuclear emite CO₂ ao gerar eletricidade?',
    opcoes: ['Sim, muito', 'Não na geração da energia', 'Só à noite'], correta: 1,
    explicacao: 'A fissão não queima combustível, então não emite CO₂ na geração.',
  ),
  Pergunta(
    categoriaId: 'energia',
    enunciado: 'Qual processo produz o calor em uma usina nuclear?',
    opcoes: ['Queima de carvão', 'Fissão do urânio', 'Energia dos ventos'], correta: 1,
    explicacao: 'Na fissão, o núcleo do urânio se divide e libera muito calor.',
  ),
  Pergunta(
    categoriaId: 'agro',
    enunciado: 'A técnica do inseto estéril serve para…',
    opcoes: ['Gerar energia', 'Controlar pragas', 'Datar fósseis'], correta: 1,
    explicacao: 'Machos estéreis reduzem a reprodução da praga.',
  ),
  Pergunta(
    categoriaId: 'agro',
    enunciado: 'Alimentos irradiados ficam radioativos?',
    opcoes: ['Não', 'Sim, por um dia', 'Sim, para sempre'], correta: 0,
    explicacao: 'A radiação só passa pelo alimento, como num raio X, e ele não vira fonte de radiação.',
  ),
  Pergunta(
    categoriaId: 'industria',
    enunciado: 'A gamagrafia serve para…',
    opcoes: ['Inspecionar soldas sem destruir a peça', 'Produzir vacinas', 'Datar fósseis'], correta: 0,
    explicacao: 'É um ensaio não destrutivo, parecido com um raio X de peças e soldas.',
  ),
  Pergunta(
    categoriaId: 'industria',
    enunciado: 'Alguns detectores de fumaça usam uma fonte radioativa minúscula de qual elemento?',
    opcoes: ['Amerício-241', 'Tecnécio-99m', 'Carbono-14'], correta: 0,
    explicacao: 'O amerício-241 é usado nos detectores do tipo ionização.',
  ),
  Pergunta(
    categoriaId: 'pesquisa',
    enunciado: 'O carbono-14 é usado para…',
    opcoes: ['Datar materiais orgânicos antigos', 'Esterilizar água', 'Medir terremotos'], correta: 0,
    explicacao: 'Ele funciona como um relógio natural para restos orgânicos.',
  ),
  Pergunta(
    categoriaId: 'pesquisa',
    enunciado: 'A meia-vida de um isótopo é…',
    opcoes: [
      'O tempo para perder metade da radioatividade',
      'O tempo que ele fica dentro do reator',
      'A idade do átomo',
    ],
    correta: 0,
    explicacao: 'Quanto menor a meia-vida, mais rápido a radioatividade diminui.',
  ),
];
