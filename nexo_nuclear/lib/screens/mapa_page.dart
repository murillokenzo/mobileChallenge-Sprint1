import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../data/categorias.dart';
import '../theme.dart';
import '../widgets/cartao.dart';

Offset _posicaoNo(int i, double w) {
  final ang = (-90 + 360 / categorias.length * i) * math.pi / 180;
  final r = w * 0.34;
  return Offset(w / 2 + r * math.cos(ang), w / 2 + r * math.sin(ang));
}

class MapaPage extends StatelessWidget {
  const MapaPage({super.key, required this.visitadas, required this.onAbrir});
  final Set<String> visitadas;
  final void Function(Categoria) onAbrir;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(18), children: [
        Text('Mapa das aplicações', style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        const Text('Toque em um ponto para abrir a explicação. Explore os cinco.',
            style: TextStyle(color: AppColors.mutado)),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.hero, borderRadius: BorderRadius.circular(24)),
          child: AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(builder: (context, cons) {
              final w = cons.maxWidth;
              return Stack(clipBehavior: Clip.none, children: [
                Positioned.fill(child: CustomPaint(painter: _FundoPainter())),
                Positioned(
                  left: w / 2 - 28, top: w / 2 - 28, width: 56, height: 56,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.brilho),
                    child: Center(child: Text('Átomo', style: TextStyle(color: Color(0xFF04141D), fontWeight: FontWeight.w700, fontSize: 11))),
                  ),
                ),
                for (int i = 0; i < categorias.length; i++) _no(i, w),
              ]);
            }),
          ),
        ),
        const SizedBox(height: 14),
        Cartao(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Explorados', style: tt.titleMedium),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: visitadas.length / categorias.length, minHeight: 10, borderRadius: BorderRadius.circular(99)),
            const SizedBox(height: 6),
            Text('${visitadas.length} de ${categorias.length} áreas exploradas', style: const TextStyle(color: AppColors.mutado)),
          ]),
        ),
      ]),
    );
  }

  Widget _no(int i, double w) {
    final c = categorias[i];
    final p = _posicaoNo(i, w);
    final visitada = visitadas.contains(c.id);
    return Positioned(
      left: p.dx - 40, top: p.dy - 34, width: 80,
      child: GestureDetector(
        onTap: () => onAbrir(c),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 64, height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: visitada ? AppColors.brilho : const Color(0xFF10303F),
              border: Border.all(color: visitada ? AppColors.ouro : AppColors.brilho, width: 2),
            ),
            child: Text(c.emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(height: 4),
          Text(c.nome, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }
}

class _FundoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linha = Paint()
      ..style = PaintingStyle.stroke
      ..color = AppColors.linha;
    final centro = size.center(Offset.zero);
    canvas.drawCircle(centro, size.width * 0.34, linha);
    for (int i = 0; i < categorias.length; i++) {
      canvas.drawLine(centro, _posicaoNo(i, size.width), linha);
    }
  }

  @override
  bool shouldRepaint(_FundoPainter old) => false;
}
