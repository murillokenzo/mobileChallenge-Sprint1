import 'package:flutter/material.dart';
import '../data/categorias.dart';
import '../data/curiosidades.dart';
import '../data/pontos_mapa.dart';
import '../data/quiz_perguntas.dart';
import '../theme.dart';
import '../widgets/cartao.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.progresso, required this.onExplorar});
  final double progresso;
  final VoidCallback onExplorar;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final fato = curiosidades[DateTime.now().difference(DateTime(2024)).inDays % curiosidades.length];

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(22, MediaQuery.of(context).padding.top + 24, 22, 32),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0E4A66), AppColors.hero],
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
          ),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: AppColors.brilho),
              ),
              child: const Text('⚓ Em parceria com o CTMSP – Marinha',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 24),
            Container(
              width: 120,
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.fundo,
                border: Border.all(color: AppColors.brilho, width: 3),
                boxShadow: const [BoxShadow(color: Color(0x884FD1FF), blurRadius: 30, spreadRadius: 4)],
              ),
              child: const Text('⚛️', style: TextStyle(fontSize: 64)),
            ),
            const SizedBox(height: 24),
            Text.rich(
              const TextSpan(children: [
                TextSpan(text: 'O '),
                TextSpan(text: 'átomo', style: TextStyle(color: AppColors.brilho)),
                TextSpan(text: ' está mais perto de você do que parece'),
              ]),
              textAlign: TextAlign.center,
              style: tt.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            const Text(
              'Da saúde à energia elétrica: descubra onde a tecnologia nuclear já trabalha todos os dias.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.mutado),
            ),
            const SizedBox(height: 22),
            FilledButton.icon(
              onPressed: onExplorar,
              icon: const Icon(Icons.explore),
              label: const Text('Começar a explorar'),
            ),
          ]),
        ),

        Padding(
          padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              _estatistica('${categorias.length}', 'áreas'),
              const SizedBox(width: 10),
              _estatistica('${pontosMapa.length}', 'pontos no mapa'),
              const SizedBox(width: 10),
              _estatistica('${perguntas.length}', 'perguntas'),
            ]),
            const SizedBox(height: 24),

            Text('Explore por área', style: tt.titleMedium),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                for (final c in categorias)
                  GestureDetector(
                    onTap: onExplorar,
                    child: Container(
                      width: 104,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.superficie,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: corDaCategoria(c.id), width: 1.5),
                      ),
                      child: Column(children: [
                        Text(c.emoji, style: const TextStyle(fontSize: 32)),
                        const SizedBox(height: 8),
                        Text(c.nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      ]),
                    ),
                  ),
              ]),
            ),
            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.superficie,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.ouro),
              ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('💡', style: TextStyle(fontSize: 32)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Você sabia?', style: TextStyle(color: AppColors.ouro, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(fato),
                    const SizedBox(height: 8),
                    const Text('Fonte: IAEA (iaea.org)', style: TextStyle(color: AppColors.mutado, fontSize: 12)),
                  ]),
                ),
              ]),
            ),
            const SizedBox(height: 24),

            Cartao(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Sua jornada', style: tt.titleMedium),
                  Text('${(progresso * 100).round()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(height: 10),
                LinearProgressIndicator(value: progresso, minHeight: 10, borderRadius: BorderRadius.circular(99)),
                const Divider(color: AppColors.linha, height: 28),
                _passo(1, 'Explore o mapa', 'Toque nas bolinhas e descubra onde cada tecnologia é usada.'),
                _passo(2, 'Teste seu conhecimento', 'Faça o quiz e ganhe a medalha Cientista.'),
                _passo(3, 'Crie seu perfil', 'Guarde suas conquistas no app.'),
              ]),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _estatistica(String numero, String rotulo) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.superficie,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.linha),
        ),
        child: Column(children: [
          Text(numero, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.brilho)),
          const SizedBox(height: 2),
          Text(rotulo, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.mutado, fontSize: 12)),
        ]),
      ),
    );
  }

  Widget _passo(int numero, String titulo, String descricao) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.brilho),
          child: Text('$numero', style: const TextStyle(color: Color(0xFF04141D), fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(descricao, style: const TextStyle(color: AppColors.mutado, fontSize: 13)),
          ]),
        ),
      ]),
    );
  }
}
