import 'package:flutter/material.dart';
import '../theme.dart';

class Cartao extends StatelessWidget {
  const Cartao({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.superficie,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.linha),
        ),
        child: child,
      );
}
