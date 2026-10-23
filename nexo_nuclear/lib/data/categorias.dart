class Categoria {
  final String id, nome, emoji, titulo, explicacao, curiosidade, exemplo, fonte;
  const Categoria({
    required this.id, required this.nome, required this.emoji, required this.titulo,
    required this.explicacao, required this.curiosidade, required this.exemplo, required this.fonte,
  });
}

const categorias = [
  Categoria(
    id: 'saude', nome: 'Saúde', emoji: '🩺', titulo: 'Medicina nuclear e radioterapia',
    explicacao: 'Pequenas quantidades de radiofármacos permitem enxergar o funcionamento de órgãos em exames como cintilografia e PET. Já a radioterapia usa radiação para tratar tumores.',
    curiosidade: 'O tecnécio-99m, muito usado em diagnóstico, perde metade da radioatividade em cerca de 6 horas.',
    exemplo: 'Exame PET com flúor-18 para localizar tumores. No Brasil, o IPEN produz radiofármacos.',
    fonte: 'IPEN (ipen.br)',
  ),
  Categoria(
    id: 'energia', nome: 'Energia', emoji: '⚡', titulo: 'Eletricidade nuclear',
    explicacao: 'Na usina, a fissão do urânio aquece água, o vapor gira uma turbina e ela gera eletricidade. Durante a operação, não há emissão de CO₂ na geração.',
    curiosidade: 'A Marinha desenvolve no Centro Experimental Aramar, em Iperó (SP), tecnologias do ciclo do combustível nuclear.',
    exemplo: 'As usinas Angra 1 e Angra 2, em Angra dos Reis (RJ), abastecem parte do sistema elétrico brasileiro.',
    fonte: 'Eletronuclear (eletronuclear.gov.br)',
  ),
  Categoria(
    id: 'agro', nome: 'Agricultura', emoji: '🌱', titulo: 'Campo e alimentos',
    explicacao: 'A radiação ajuda a controlar pragas, melhorar variedades de plantas e conservar alimentos, reduzindo perdas e o uso de agrotóxicos.',
    curiosidade: 'Na técnica do inseto estéril, machos irradiados são soltos e não geram descendentes, diminuindo a praga.',
    exemplo: 'A Biofábrica Moscamed, na Bahia, usa essa técnica contra a mosca-das-frutas.',
    fonte: 'IAEA (iaea.org)',
  ),
  Categoria(
    id: 'industria', nome: 'Indústria', emoji: '🏭', titulo: 'Inspeção e esterilização',
    explicacao: 'A gamagrafia inspeciona soldas e peças sem destruí-las. A radiação também esteriliza seringas, luvas e outros produtos médicos.',
    curiosidade: 'Muitos detectores de fumaça usam uma fonte minúscula de amerício-241.',
    exemplo: 'Inspeção de soldas em tubulações de petróleo e gás.',
    fonte: 'CNEN (gov.br/cnen)',
  ),
  Categoria(
    id: 'pesquisa', nome: 'Pesquisa', emoji: '🔬', titulo: 'Ciência e datação',
    explicacao: 'Reatores de pesquisa e traçadores radioativos ajudam a estudar materiais, o meio ambiente e a história da humanidade.',
    curiosidade: 'O carbono-14 tem meia-vida de cerca de 5.730 anos e permite datar restos orgânicos antigos.',
    exemplo: 'Datação de fósseis e artefatos arqueológicos; o reator IEA-R1, em São Paulo, é voltado à pesquisa.',
    fonte: 'IPEN (ipen.br)',
  ),
];
