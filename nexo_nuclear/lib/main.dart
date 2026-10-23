import 'package:flutter/material.dart';
import 'data/categorias.dart';
import 'models/perfil.dart';
import 'screens/conquistas_page.dart';
import 'screens/detalhe_categoria_page.dart';
import 'screens/home_page.dart';
import 'screens/mapa_page.dart';
import 'screens/perfil_page.dart';
import 'screens/quiz_page.dart';
import 'theme.dart';

void main() => runApp(const ExploradorApp());

class ExploradorApp extends StatelessWidget {
  const ExploradorApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Explorador Nuclear',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        home: const AppShell(),
      );
}

/// Guarda o estado do app inteiro (setState) e distribui para as telas.
class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _aba = 0;
  final Set<String> _visitadas = {};
  int _melhorPontuacao = 0;
  bool _quizConcluido = false;
  Perfil? _perfil;

  double get _progresso =>
      (_visitadas.length / categorias.length * 50 + (_quizConcluido ? 30 : 0) + (_perfil != null ? 20 : 0)) / 100;

  void _irPara(int i) => setState(() => _aba = i);

  Future<void> _abrirCategoria(Categoria c) async {
    final estavaCompleto = _visitadas.length == categorias.length;
    setState(() => _visitadas.add(c.id));
    await Navigator.push(context, MaterialPageRoute(builder: (_) => DetalheCategoriaPage(categoria: c)));
    if (!mounted) return;
    if (!estavaCompleto && _visitadas.length == categorias.length) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Medalha Explorador desbloqueada! 🧭')));
    }
  }

  void _finalizarQuiz(int pontos) => setState(() {
        _quizConcluido = true;
        if (pontos > _melhorPontuacao) _melhorPontuacao = pontos;
      });

  void _salvarPerfil(Perfil p) => setState(() => _perfil = p);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: _aba, children: [
          HomePage(progresso: _progresso, onExplorar: () => _irPara(1)),
          MapaPage(visitadas: _visitadas, onAbrir: _abrirCategoria),
          QuizPage(onFinalizar: _finalizarQuiz),
          PerfilPage(perfil: _perfil, onSalvar: _salvarPerfil, onIrConquistas: () => _irPara(4)),
          ConquistasPage(
            visitadas: _visitadas.length,
            melhorPontuacao: _melhorPontuacao,
            perfil: _perfil,
            progresso: _progresso,
          ),
        ]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _aba,
          onDestinationSelected: _irPara,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Início'),
            NavigationDestination(icon: Icon(Icons.map_outlined), label: 'Mapa'),
            NavigationDestination(icon: Icon(Icons.quiz_outlined), label: 'Quiz'),
            NavigationDestination(icon: Icon(Icons.person_outline), label: 'Perfil'),
            NavigationDestination(icon: Icon(Icons.emoji_events_outlined), label: 'Conquistas'),
          ],
        ),
      );
}
