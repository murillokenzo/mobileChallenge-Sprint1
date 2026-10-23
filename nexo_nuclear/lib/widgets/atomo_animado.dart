import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme.dart';

class AtomoAnimado extends StatefulWidget {
  const AtomoAnimado({super.key, this.tamanho = 200});
  final double tamanho;
  @override
  State<AtomoAnimado> createState() => _AtomoAnimadoState();
}

class _AtomoAnimadoState extends State<AtomoAnimado> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _c,
        builder: (_, __) => CustomPaint(size: Size.square(widget.tamanho), painter: _AtomoPainter(_c.value)),
      );
}

class _AtomoPainter extends CustomPainter {
  _AtomoPainter(this.t);
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final centro = size.center(Offset.zero);
    final rx = size.width * 0.41, ry = size.width * 0.145;
    final orbita = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0x804FD1FF);
    final eletron = Paint()..color = AppColors.ouro;
    for (int i = 0; i < 3; i++) {
      canvas.save();
      canvas.translate(centro.dx, centro.dy);
      canvas.rotate(i * math.pi / 3);
      canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: rx * 2, height: ry * 2), orbita);
      final ang = 2 * math.pi * t * (i + 1);
      canvas.drawCircle(Offset(rx * math.cos(ang), ry * math.sin(ang)), 5, eletron);
      canvas.restore();
    }
    canvas.drawCircle(centro, 12, Paint()..color = AppColors.brilho);
  }

  @override
  bool shouldRepaint(_AtomoPainter old) => old.t != t;
}
