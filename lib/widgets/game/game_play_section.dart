import 'dart:ui';
import 'package:flutter/material.dart';
import '../../domain/entities/game_state_entity.dart';

class GamePlaySection extends StatelessWidget {
  final GameStateEntity state;
  final Animation<double> animation;

  const GamePlaySection(
      {super.key, required this.state, required this.animation});

  @override
  Widget build(BuildContext context) {
    if (state.currentWord == null) {
      return Center(
        child: Text(
          'Kelime bulunamadı.',
          style: TextStyle(
            color: Colors.amber.shade300,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Current Word Card with Blur Effect
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (animation.value * 0.05),
              child: Stack(
                children: [
                  child!,
                  if (state.status == GameStatus.ready)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black.withOpacity(0.3),
                            child: Center(
                              child: Text(
                                'Başla\'ya tıklayınca kelime gösterilecek',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.amber.shade300,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.amber.shade800.withOpacity(0.7),
                  Colors.amber.shade600.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              state.currentWord!.word.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Forbidden Words with Blur Effect
        Text(
          'Yasaklı Kelimeler',
          style: TextStyle(
            color: Colors.red.shade300,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade800.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.red.shade800.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: ListView.builder(
                  itemCount: state.currentWord!.forbiddenWords.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade900.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        state.currentWord!.forbiddenWords[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (state.status == GameStatus.ready)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
