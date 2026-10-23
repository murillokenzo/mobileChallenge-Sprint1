import 'package:flutter/material.dart';
import '../data/categorias.dart';
import '../data/quiz_perguntas.dart';
import '../models/perfil.dart';
import '../theme.dart';
import '../widgets/cartao.dart';

class ConquistasPage extends StatelessWidget {
  const ConquistasPage({
    super.key, required this.visitadas, required this.melhorPontuacao,
    required this.perfil, required this.progresso,
  });
  final int visitadas, melhorPontuacao;
  final Perfil? perfil;
  final double progresso;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final explorador = visitadas >= categorias.length;
    final cientista = melhorPontuacao >= notaParaMedalha;
    final cadastrado = perfil != null;
    final medalhas = [
      ('🧭', 'Explorador', 'Abra as ${categorias.length} áreas', explorador),
      ('🧪', 'Cientista', 'Acerte $notaParaMedalha no quiz', cientista),
      ('🪪', 'Cadastrado', 'Salve seu perfil', cadastrado),
      ('☢️', 'Mestre atômico', 'Conquiste as 3', explorador && cientista && cadastrado),
    ];
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(18), children: [
        Text('Conquistas', style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 14),
        Cartao(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(perfil != null ? 'Olá, ${perfil!.primeiroNome}!' : 'Explorador anônimo', style: tt.titleMedium),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: progresso, minHeight: 10, borderRadius: BorderRadius.circular(99)),
            const SizedBox(height: 6),
            Text('${(progresso * 100).round()}% do caminho concluído', style: const TextStyle(color: AppColors.mutado)),
          ]),
        ),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.1,
          children: [for (final m in medalhas) _medalha(m.$1, m.$2, m.$3, m.$4)],
        ),
        const SizedBox(height: 14),
        Cartao(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Fontes confiáveis', style: tt.titleMedium),
            const SizedBox(height: 8),
            for (final f in const [
              'CNEN – Comissão Nacional de Energia Nuclear (gov.br/cnen)',
              'IAEA – Agência Internacional de Energia Atômica (iaea.org)',
              'Eletronuclear – usinas de Angra (eletronuclear.gov.br)',
              'IPEN – Instituto de Pesquisas Energéticas e Nucleares (ipen.br)',
              'Marinha do Brasil – Programa Nuclear da Marinha (marinha.mil.br)',
            ])
              Padding(padding: const EdgeInsets.only(bottom: 4), child: Text('• $f', style: const TextStyle(color: AppColors.mutado))),
          ]),
        ),
      ]),
    );
  }

  Widget _medalha(String emoji, String nome, String dica, bool on) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: on ? AppColors.superficie : null,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: on ? AppColors.ouro : AppColors.linha, width: 1.5),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Opacity(opacity: on ? 1 : 0.35, child: Text(emoji, style: const TextStyle(fontSize: 36))),
          const SizedBox(height: 6),
          Text(nome, style: const TextStyle(fontWeight: FontWeight.w700)),
          Text(on ? 'Desbloqueada' : dica, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.mutado, fontSize: 12)),
        ]),
      );
}
