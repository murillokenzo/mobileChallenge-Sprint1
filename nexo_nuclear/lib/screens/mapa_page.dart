import 'package:flutter/material.dart';
import '../data/categorias.dart';
import '../data/pontos_mapa.dart';
import '../theme.dart';
import '../widgets/cartao.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key, required this.visitadas, required this.onVisitar});
  final Set<String> visitadas;
  final void Function(String categoriaId) onVisitar;

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final Set<String> _vistos = {}; // pontos que o usuário já abriu

  void _abrir(PontoMapa p) {
    setState(() => _vistos.add(p.id));
    widget.onVisitar(p.categoriaId);

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${p.emoji} ${p.titulo}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${p.regiao} · ${p.local}',
                  style: TextStyle(color: corDaCategoria(p.categoriaId), fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(p.uso),
              const SizedBox(height: 10),
              Text('Curiosidade: ${p.curiosidade}'),
              const SizedBox(height: 10),
              Text('Fonte: ${p.fonte}', style: const TextStyle(fontSize: 12, color: AppColors.ouro)),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Fechar')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text('Mapa do Brasil', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          const Text('Toque nas bolinhas para ver onde cada tecnologia é usada.',
              style: TextStyle(color: AppColors.mutado)),
          const SizedBox(height: 14),

          // Imagem do mapa com as bolinhas por cima (Stack + Positioned)
          AspectRatio(
            aspectRatio: 0.98,
            child: LayoutBuilder(
              builder: (context, c) {
                return Stack(
                  children: [
                    Positioned.fill(child: Image.asset('assets/brasil.png', fit: BoxFit.fill)),
                    for (final p in pontosMapa)
                      Positioned(
                        left: p.x * c.maxWidth - 18,
                        top: p.y * c.maxHeight - 18,
                        child: GestureDetector(
                          onTap: () => _abrir(p),
                          child: Container(
                            width: 36,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _vistos.contains(p.id) ? corDaCategoria(p.categoriaId) : AppColors.fundo,
                              border: Border.all(color: corDaCategoria(p.categoriaId), width: 3),
                            ),
                            child: Text(p.emoji),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 14),

          // Legenda das cores
          Wrap(
            spacing: 14,
            runSpacing: 8,
            children: [
              for (final c in categorias)
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.circle, size: 12, color: corDaCategoria(c.id)),
                  const SizedBox(width: 6),
                  Text(c.nome),
                ]),
            ],
          ),
          const SizedBox(height: 14),

          Cartao(
            child: Text('${_vistos.length} de ${pontosMapa.length} pontos explorados'),
          ),
        ],
      ),
    );
  }
}
