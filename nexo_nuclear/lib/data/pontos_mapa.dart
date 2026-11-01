import 'package:flutter/material.dart';

class PontoMapa {
  final String id, categoriaId, emoji, regiao, local, titulo, uso, curiosidade, fonte;
  final double x, y; // posição no mapa: 0 a 1 (esquerda->direita, cima->baixo)
  const PontoMapa({
    required this.id, required this.categoriaId, required this.emoji, required this.regiao,
    required this.local, required this.x, required this.y, required this.titulo,
    required this.uso, required this.curiosidade, required this.fonte,
  });
}

/// Cor de cada categoria (usada nas bolinhas, no popup e na legenda).
Color corDaCategoria(String id) {
  switch (id) {
    case 'saude':
      return const Color(0xFF7DD3FC);
    case 'energia':
      return const Color(0xFFFFC15A);
    case 'agro':
      return const Color(0xFF6EE7A0);
    case 'industria':
      return const Color(0xFFB794F6);
    default:
      return const Color(0xFF5EEAD4); // pesquisa
  }
}

// Posições aproximadas por região (x e y vão de 0 a 1).
const pontosMapa = [
  PontoMapa(
    id: 'angra', categoriaId: 'energia', emoji: '⚡', regiao: 'Sudeste · RJ',
    local: 'Angra dos Reis e Resende', x: 0.76, y: 0.737,
    titulo: 'Eletricidade e combustível nuclear',
    uso: 'Em Angra dos Reis, as usinas Angra 1 e Angra 2 geram eletricidade a partir da fissão do urânio. Em Resende, a INB fabrica elementos combustíveis, parte do ciclo do combustível nuclear.',
    curiosidade: 'O calor da fissão produz vapor que gira uma turbina, como em outras usinas térmicas, mas sem queimar combustível.',
    fonte: 'Eletronuclear e INB',
  ),
  PontoMapa(
    id: 'aramar', categoriaId: 'energia', emoji: '⚡', regiao: 'Sudeste · SP',
    local: 'Iperó (Centro Experimental Aramar)', x: 0.643, y: 0.754,
    titulo: 'Tecnologia da Marinha no ciclo do combustível',
    uso: 'No Centro Experimental Aramar, a Marinha desenvolve tecnologias como a ultracentrifugação, usada no enriquecimento de urânio, dentro do Programa Nuclear da Marinha, que também busca a geração de energia elétrica.',
    curiosidade: 'O Programa Nuclear da Marinha é desenvolvido desde 1979.',
    fonte: 'Marinha do Brasil (marinha.mil.br)',
  ),
  PontoMapa(
    id: 'ipen', categoriaId: 'saude', emoji: '🩺', regiao: 'Sudeste · SP',
    local: 'São Paulo (IPEN)', x: 0.69, y: 0.681,
    titulo: 'Radiofármacos para diagnóstico e tratamento',
    uso: 'O IPEN, na capital paulista, produz radiofármacos que abastecem serviços de medicina nuclear para exames e tratamentos.',
    curiosidade: 'Os radiofármacos têm meia-vida curta, então precisam ser produzidos e entregues rapidamente.',
    fonte: 'IPEN (ipen.br)',
  ),
  PontoMapa(
    id: 'cdtn', categoriaId: 'pesquisa', emoji: '🔬', regiao: 'Sudeste · MG',
    local: 'Belo Horizonte (CDTN)', x: 0.75, y: 0.608,
    titulo: 'Pesquisa em tecnologia nuclear',
    uso: 'O Centro de Desenvolvimento da Tecnologia Nuclear (CDTN/CNEN) realiza pesquisa e desenvolvimento em áreas da tecnologia nuclear.',
    curiosidade: 'Centros de pesquisa formam profissionais e dão suporte técnico às aplicações da área.',
    fonte: 'CNEN (gov.br/cnen)',
  ),
  PontoMapa(
    id: 'campos', categoriaId: 'industria', emoji: '🏭', regiao: 'Sudeste · RJ/ES',
    local: 'Bacia de Campos (polo de petróleo)', x: 0.85, y: 0.696,
    titulo: 'Gamagrafia na indústria do petróleo',
    uso: 'A gamagrafia usa radiação para inspecionar soldas e estruturas sem destruí-las, ajudando a garantir a segurança de dutos e equipamentos.',
    curiosidade: 'É um ensaio não destrutivo: a peça é analisada de forma parecida com um raio X.',
    fonte: 'CNEN (gov.br/cnen)',
  ),
  PontoMapa(
    id: 'juazeiro', categoriaId: 'agro', emoji: '🌱', regiao: 'Nordeste · BA',
    local: 'Juazeiro (Biofábrica Moscamed)', x: 0.838, y: 0.377,
    titulo: 'Técnica do inseto estéril',
    uso: 'Machos de mosca-das-frutas são esterilizados por radiação e soltos no campo. Sem gerar descendentes, eles reduzem a população da praga e protegem a fruticultura.',
    curiosidade: 'É um controle de pragas que reduz a necessidade de inseticidas.',
    fonte: 'IAEA (iaea.org)',
  ),
  PontoMapa(
    id: 'caetite', categoriaId: 'energia', emoji: '⚡', regiao: 'Nordeste · BA',
    local: 'Caetité', x: 0.787, y: 0.496,
    titulo: 'Mineração de urânio',
    uso: 'Em Caetité, a INB extrai e processa urânio, matéria-prima que dá início ao ciclo do combustível nuclear.',
    curiosidade: 'O urânio passa por etapas como concentração, conversão e enriquecimento antes de virar combustível.',
    fonte: 'INB (inb.gov.br)',
  ),
  PontoMapa(
    id: 'recife', categoriaId: 'pesquisa', emoji: '🔬', regiao: 'Nordeste · PE',
    local: 'Recife (CRCN-NE)', x: 0.968, y: 0.342,
    titulo: 'Ciência nuclear no Nordeste',
    uso: 'O Centro Regional de Ciências Nucleares do Nordeste (CRCN-NE/CNEN) atua em pesquisa, ensino e serviços em tecnologia nuclear para a região.',
    curiosidade: 'Os centros regionais levam a tecnologia nuclear para além do Sudeste.',
    fonte: 'CNEN (gov.br/cnen)',
  ),
  PontoMapa(
    id: 'centro_oeste', categoriaId: 'agro', emoji: '🌱', regiao: 'Centro-Oeste',
    local: 'Regiões produtoras de grãos e carne', x: 0.475, y: 0.532,
    titulo: 'Isótopos no estudo do solo',
    uso: 'Técnicas nucleares, como o uso de isótopos, ajudam a estudar solo, adubação e uso de água, apoiando uma agricultura mais eficiente.',
    curiosidade: 'Os isótopos funcionam como etiquetas que permitem acompanhar o caminho dos nutrientes na planta.',
    fonte: 'IAEA (iaea.org)',
  ),
  PontoMapa(
    id: 'amazonia', categoriaId: 'pesquisa', emoji: '🔬', regiao: 'Norte · AM',
    local: 'Amazônia (Manaus)', x: 0.35, y: 0.218,
    titulo: 'Isótopos para entender a floresta',
    uso: 'Isótopos estáveis e radioativos são usados por pesquisadores para estudar o ciclo do carbono e da água na floresta e para datar árvores.',
    curiosidade: 'Datar árvores com carbono-14 ajuda a entender há quanto tempo a floresta armazena carbono.',
    fonte: 'IAEA (iaea.org)',
  ),
  PontoMapa(
    id: 'sul', categoriaId: 'saude', emoji: '🩺', regiao: 'Sul',
    local: 'Capitais do Sul', x: 0.562, y: 0.886,
    titulo: 'Medicina nuclear nos hospitais',
    uso: 'Hospitais dos grandes centros da região usam exames de medicina nuclear, como cintilografia e PET, além de radioterapia no tratamento de tumores.',
    curiosidade: 'O PET mostra o consumo de energia das células, o que ajuda a localizar tumores.',
    fonte: 'CNEN (gov.br/cnen)',
  ),
];
