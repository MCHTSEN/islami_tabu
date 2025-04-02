import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;

  const BackgroundGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.teal.shade900,
            Colors.blueGrey.shade900,
            Colors.indigo.shade900,
          ],
        ),
      ),
      child: child,
    );
  }
}
