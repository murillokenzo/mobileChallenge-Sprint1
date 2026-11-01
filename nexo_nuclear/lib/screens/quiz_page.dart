import 'package:flutter/material.dart';
import '../data/categorias.dart';
import '../data/pontos_mapa.dart';
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
  bool _iniciado = false; // false = mostra a tela inicial (lobby)
  bool _valeMedalha = false;
  List<Pergunta> _lista = [];
  int _indice = 0;
  int _pontos = 0;
  int _melhor = 0;
  int? _escolhida;

  bool get _respondida => _escolhida != null;
  bool get _terminou => _indice >= _lista.length;

  void _iniciar(List<Pergunta> lista, {required bool valeMedalha}) {
    setState(() {
      _lista = lista;
      _valeMedalha = valeMedalha;
      _iniciado = true;
      _indice = 0;
      _pontos = 0;
      _escolhida = null;
    });
  }

  void _voltarAoInicio() => setState(() => _iniciado = false);

  void _responder(int i) {
    if (_respondida) return;
    setState(() {
      _escolhida = i;
      if (i == _lista[_indice].correta) _pontos++;
    });
  }

  void _avancar() {
    setState(() {
      _indice++;
      _escolhida = null;
      if (_terminou && _valeMedalha && _pontos > _melhor) _melhor = _pontos;
    });
    if (_terminou && _valeMedalha) widget.onFinalizar(_pontos);
  }

  Color _cor(int i, Pergunta p) {
    if (!_respondida) return AppColors.linha;
    if (i == p.correta) return Colors.green;
    if (i == _escolhida) return Colors.redAccent;
    return AppColors.linha;
  }

  @override
  Widget build(BuildContext context) {
    if (!_iniciado) return _telaInicial();
    if (_terminou) return _telaResultado();
    return _telaPergunta();
  }

  // ---------- TELA INICIAL ----------
  Widget _telaInicial() {
    final tt = Theme.of(context).textTheme;
    final progresso = (_melhor / notaParaMedalha).clamp(0.0, 1.0).toDouble();
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(18), children: [
        Cartao(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                width: 56, height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: AppColors.brilho, borderRadius: BorderRadius.circular(16)),
                child: const Text('🎯', style: TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Quiz nuclear', style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                  const Text('Teste o que você aprendeu!', style: TextStyle(color: AppColors.mutado)),
                ]),
              ),
            ]),
            const SizedBox(height: 14),
            Wrap(spacing: 8, runSpacing: 8, children: [
              _selo('🏆 Melhor: $_melhor/${perguntas.length}'),
              _selo('🧪 Medalha: $notaParaMedalha acertos'),
            ]),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Progresso para a medalha Cientista', style: TextStyle(color: AppColors.mutado, fontSize: 12)),
              Text('${_melhor > notaParaMedalha ? notaParaMedalha : _melhor} / $notaParaMedalha',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: progresso, minHeight: 10, borderRadius: BorderRadius.circular(99)),
          ]),
        ),
        Text('Escolha um desafio', style: tt.titleMedium),
        const SizedBox(height: 10),
        _cartaoModo(
          emoji: '🎯',
          cor: AppColors.ouro,
          titulo: 'Desafio completo',
          descricao: 'Todas as perguntas. Acerte $notaParaMedalha para ganhar a medalha Cientista.',
          qtd: perguntas.length,
          onIniciar: () => _iniciar(perguntas, valeMedalha: true),
        ),
        ..._cartoesCategorias(),
      ]),
    );
  }

  // Cria um cartão de treino para cada categoria que tenha perguntas
  List<Widget> _cartoesCategorias() {
    final cartoes = <Widget>[];
    for (final c in categorias) {
      final qs = perguntas.where((p) => p.categoriaId == c.id).toList();
      if (qs.isEmpty) continue;
      cartoes.add(_cartaoModo(
        emoji: c.emoji,
        cor: corDaCategoria(c.id),
        titulo: 'Treino: ${c.nome}',
        descricao: 'Treino rápido sobre ${c.nome.toLowerCase()}. Não vale medalha.',
        qtd: qs.length,
        onIniciar: () => _iniciar(qs, valeMedalha: false),
      ));
    }
    return cartoes;
  }

  Widget _cartaoModo({
    required String emoji,
    required Color cor,
    required String titulo,
    required String descricao,
    required int qtd,
    required VoidCallback onIniciar,
  }) {
    return Cartao(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 56, height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: cor, borderRadius: BorderRadius.circular(16)),
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(titulo, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(descricao, style: const TextStyle(color: AppColors.mutado, fontSize: 13)),
            ]),
          ),
        ]),
        const Divider(color: AppColors.linha, height: 24),
        Row(children: [
          const Icon(Icons.help_outline, size: 18, color: AppColors.mutado),
          const SizedBox(width: 6),
          Text('$qtd perguntas', style: const TextStyle(color: AppColors.mutado)),
          const Spacer(),
          FilledButton(onPressed: onIniciar, child: const Text('Iniciar →')),
        ]),
      ]),
    );
  }

  Widget _selo(String texto) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.fundo,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.linha),
        ),
        child: Text(texto, style: const TextStyle(fontWeight: FontWeight.w600)),
      );

  // ---------- TELA DA PERGUNTA ----------
  Widget _telaPergunta() {
    final tt = Theme.of(context).textTheme;
    final p = _lista[_indice];
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(18), children: [
        Row(children: [
          IconButton(onPressed: _voltarAoInicio, icon: const Icon(Icons.arrow_back)),
          Text('Quiz nuclear', style: tt.titleLarge),
        ]),
        const SizedBox(height: 6),
        Text('Pergunta ${_indice + 1} de ${_lista.length} · Pontos: $_pontos',
            style: const TextStyle(color: AppColors.mutado)),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: _indice / _lista.length, minHeight: 10, borderRadius: BorderRadius.circular(99)),
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
            child: Text(_indice == _lista.length - 1 ? 'Ver resultado' : 'Próxima pergunta'),
          ),
        ],
      ]),
    );
  }

  // ---------- TELA DE RESULTADO ----------
  Widget _telaResultado() {
    final tt = Theme.of(context).textTheme;
    String mensagem;
    if (!_valeMedalha) {
      mensagem = 'Treino concluído! Tente o desafio completo para ganhar a medalha.';
    } else if (_pontos >= notaParaMedalha) {
      mensagem = 'Medalha Cientista desbloqueada! 🧪';
    } else {
      mensagem = 'Faltou pouco! Acerte $notaParaMedalha para ganhar a medalha.';
    }
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(18), children: [
        Text('Quiz nuclear', style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 14),
        Cartao(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Você acertou $_pontos de ${_lista.length}', style: tt.titleLarge),
            const SizedBox(height: 8),
            Text(mensagem, style: const TextStyle(color: AppColors.mutado)),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: () => _iniciar(_lista, valeMedalha: _valeMedalha),
              child: const Text('Jogar novamente'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(onPressed: _voltarAoInicio, child: const Text('Voltar ao início')),
          ]),
        ),
      ]),
    );
  }
}
