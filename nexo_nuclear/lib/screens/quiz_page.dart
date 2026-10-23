import 'package:flutter/material.dart';
import '../data/quiz_perguntas.dart';
import '../theme.dart';
import '../widgets/cartao.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.onFinalizar});
  final void Function(int pontos) onFinalizar;
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _indice = 0;
  int _pontos = 0;
  int? _escolhida;

  bool get _respondida => _escolhida != null;
  bool get _terminou => _indice >= perguntas.length;

  void _responder(int i) {
    if (_respondida) return;
    setState(() {
      _escolhida = i;
      if (i == perguntas[_indice].correta) _pontos++;
    });
  }

  void _avancar() {
    setState(() {
      _indice++;
      _escolhida = null;
    });
    if (_terminou) widget.onFinalizar(_pontos);
  }

  void _reiniciar() => setState(() {
        _indice = 0;
        _pontos = 0;
        _escolhida = null;
      });

  Color _cor(int i, Pergunta p) {
    if (!_respondida) return AppColors.linha;
    if (i == p.correta) return Colors.green;
    if (i == _escolhida) return Colors.redAccent;
    return AppColors.linha;
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final titulo = Text('Quiz nuclear', style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w800));
    if (_terminou) {
      return SafeArea(
        child: ListView(padding: const EdgeInsets.all(18), children: [
          titulo,
          const SizedBox(height: 14),
          Cartao(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Você acertou $_pontos de ${perguntas.length}', style: tt.titleLarge),
              const SizedBox(height: 8),
              Text(
                _pontos >= notaParaMedalha
                    ? 'Medalha Cientista desbloqueada! 🧪'
                    : 'Revise o mapa e tente de novo para chegar a $notaParaMedalha acertos.',
                style: const TextStyle(color: AppColors.mutado),
              ),
              const SizedBox(height: 14),
              FilledButton(onPressed: _reiniciar, child: const Text('Jogar novamente')),
            ]),
          ),
        ]),
      );
    }
    final p = perguntas[_indice];
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(18), children: [
        titulo,
        const SizedBox(height: 10),
        Text('Pergunta ${_indice + 1} de ${perguntas.length} · Pontos: $_pontos',
            style: const TextStyle(color: AppColors.mutado)),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: _indice / perguntas.length, minHeight: 10, borderRadius: BorderRadius.circular(99)),
        const SizedBox(height: 18),
        Text(p.enunciado, style: tt.titleLarge),
        const SizedBox(height: 14),
        for (int i = 0; i < p.opcoes.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: OutlinedButton(
              onPressed: () => _responder(i),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.texto,
                side: BorderSide(color: _cor(i, p), width: 1.5),
                alignment: Alignment.centerLeft,
                minimumSize: const Size.fromHeight(52),
                padding: const EdgeInsets.all(16),
              ),
              child: Text(p.opcoes[i]),
            ),
          ),
        if (_respondida) ...[
          const SizedBox(height: 6),
          Cartao(child: Text('${_escolhida == p.correta ? 'Correto!' : 'Quase!'} ${p.explicacao}')),
          FilledButton(
            onPressed: _avancar,
            child: Text(_indice == perguntas.length - 1 ? 'Ver resultado' : 'Próxima pergunta'),
          ),
        ],
      ]),
    );
  }
}
