import 'package:flutter/material.dart';

import 'app_3d_buton.dart';

class ControlButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color color;

  const ControlButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return App3DButton(
      text: label.toUpperCase(),
      onTap: onPressed,
      primaryColor: color,
      secondaryColor: _getDarkerColor(color),
      shadowColor: _getShadowColor(color),
      icon: icon,
      height: 60,
      borderRadius: 20,
      textStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w900,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    );
  }

  Color _getDarkerColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0)).toColor();
  }

  Color _getShadowColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0)).toColor();
  }
}
