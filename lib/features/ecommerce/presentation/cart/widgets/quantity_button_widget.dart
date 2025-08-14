import 'package:flutter/material.dart';

class QuantityButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const QuantityButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF6C5CE7), width: 1.5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: const Color(0xFF6C5CE7), size: 18),
      ),
    );
  }
}
