import 'package:flutter/material.dart';
import '../data/curiosidades.dart';
import '../theme.dart';
import '../widgets/atomo_animado.dart';
import '../widgets/cartao.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.progresso, required this.onExplorar});
  final double progresso;
  final VoidCallback onExplorar;

  @override
  Widget build(BuildContext context) {
    final fato = curiosidades[DateTime.now().difference(DateTime(2024)).inDays % curiosidades.length];
    final tt = Theme.of(context).textTheme;
    const mutado = TextStyle(color: AppColors.mutado);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(22, MediaQuery.of(context).padding.top + 24, 22, 30),
          decoration: const BoxDecoration(
            color: AppColors.hero,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Center(child: AtomoAnimado()),
            const SizedBox(height: 12),
            Text('O átomo está mais perto de você do que parece',
                style: tt.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            const Text('Da saúde à energia elétrica: descubra onde a tecnologia nuclear já trabalha todos os dias.',
                style: mutado),
            const SizedBox(height: 18),
            FilledButton(onPressed: onExplorar, child: const Text('Começar a explorar')),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            Cartao(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Seu progresso', style: tt.titleMedium),
                const SizedBox(height: 10),
                LinearProgressIndicator(value: progresso, minHeight: 10, borderRadius: BorderRadius.circular(99)),
                const SizedBox(height: 6),
                Text('${(progresso * 100).round()}% concluído', style: mutado),
              ]),
            ),
            Cartao(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Curiosidade do dia', style: tt.titleMedium),
                const SizedBox(height: 6),
                Text(fato),
                const SizedBox(height: 8),
                const Text('Fonte: IAEA (iaea.org)', style: TextStyle(color: AppColors.ouro, fontSize: 12)),
              ]),
            ),
            Cartao(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Sobre o projeto', style: tt.titleMedium),
                const SizedBox(height: 6),
                const Text(
                  'Protótipo educativo do Challenge 2026 com o Centro Tecnológico da Marinha em São Paulo (CTMSP), sobre o ciclo do combustível nuclear e a geração de energia elétrica.',
                  style: mutado,
                ),
              ]),
            ),
          ]),
        ),
      ],
    );
  }
}
