import 'package:flutter/material.dart';
import '../data/categorias.dart';
import '../theme.dart';
import '../widgets/cartao.dart';

/// Recebe a categoria por parâmetro (passagem de dados entre telas).
class DetalheCategoriaPage extends StatelessWidget {
  const DetalheCategoriaPage({super.key, required this.categoria});
  final Categoria categoria;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(categoria.nome)),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Text(categoria.emoji, style: const TextStyle(fontSize: 56)),
        const SizedBox(height: 8),
        Text(categoria.titulo, style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Text(categoria.explicacao),
        const SizedBox(height: 16),
        Cartao(child: Text('Curiosidade: ${categoria.curiosidade}')),
        Cartao(child: Text('Exemplo real: ${categoria.exemplo}')),
        Text('Fonte: ${categoria.fonte}', style: const TextStyle(color: AppColors.ouro, fontSize: 12)),
        const SizedBox(height: 20),
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Voltar ao mapa')),
      ]),
    );
  }
}
