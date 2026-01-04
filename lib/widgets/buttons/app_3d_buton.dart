import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App3DButton extends ConsumerStatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color primaryColor;
  final Color secondaryColor;
  final Color shadowColor;
  final IconData? icon;
  final Color? iconColor;
  final Widget? leading;
  final double height;
  final double? width;
  final double borderRadius;
  final TextStyle? textStyle;

  const App3DButton({
    super.key,
    required this.text,
    required this.onTap,
    this.primaryColor = const Color(0xFF2A9D8F),
    this.secondaryColor = const Color(0xFF264653),
    this.shadowColor = const Color(0xFF1D6F66),
    this.icon = Icons.arrow_forward_ios,
    this.iconColor,
    this.leading,
    this.height = 64,
    this.width,
    this.borderRadius = 20,
    this.textStyle,
  });

  @override
  ConsumerState<App3DButton> createState() => _App3DButtonState();
}

extension ColorDarken on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}

class _App3DButtonState extends ConsumerState<App3DButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () async {
        HapticFeedback.mediumImpact();

        // 1. Give the "down" state time to be visible
        // We wait a bit even after release to ensure the press is felt
        await Future.delayed(const Duration(milliseconds: 150));

        // 2. Trigger the "up" animation
        if (mounted) {
          setState(() => _isPressed = false);
        }

        // 3. Wait for the return animation to finish before navigating
        await Future.delayed(const Duration(milliseconds: 150));

        if (!mounted) return;
        widget.onTap();
      },
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 100),
        tween: Tween(begin: 0.0, end: _isPressed ? 1.0 : 0.0),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(-4 * value, 4 * value),
            child: Transform.scale(
              scale: 1.0 - (0.02 * value),
              alignment: Alignment.bottomLeft,
              child: child,
            ),
          );
        },
        child: Container(
          width: widget.width ?? double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              colors: [widget.primaryColor, widget.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              // Main 3D Depth Shadow (Left-Bottom)
              BoxShadow(
                color: widget.shadowColor.withOpacity(0.6),
                blurRadius: 0,
                offset: Offset(_isPressed ? -2 : -6, _isPressed ? 2 : 6),
              ),
              // Soft Glow
              BoxShadow(
                color: widget.primaryColor.withOpacity(0.4),
                blurRadius: _isPressed ? 8 : 12,
                offset: Offset(_isPressed ? -1 : -3, _isPressed ? 1 : 3),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.leading != null) ...[
                  widget.leading!,
                  const SizedBox(width: 12),
                ],
                Text(widget.text, style: widget.textStyle),
                if (widget.icon != null) ...[
                  const SizedBox(width: 12),
                  Icon(
                    widget.icon,
                    color: widget.iconColor ?? Colors.white,
                    size: 18,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
