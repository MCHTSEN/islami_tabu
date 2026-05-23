import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:islami_tabu/l10n/generated/app_localizations.dart';

import '../../domain/entities/game_state_entity.dart';

class GamePlaySection extends StatelessWidget {
  final GameStateEntity state;
  final Animation<double> animation;

  const GamePlaySection(
      {super.key, required this.state, required this.animation});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (state.currentWord == null) {
      return Center(
        child: Text(
          l10n.gameNoWordsFound,
          style: TextStyle(
            color: Colors.amber.shade300,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxHeight < 500;

        return Column(
          children: [
            // Floating Status Bar (Team & Timer)
            _buildStatusBar(isSmallScreen),

            SizedBox(height: isSmallScreen ? 12 : 20),

            // Main Word Card
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (animation.value * 0.02),
                  child: child,
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber.withOpacity(0.6),
                      Colors.amber.shade800.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 10 : 15,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueGrey.shade900.withOpacity(0.85),
                            Colors.black.withOpacity(0.95),
                          ],
                        ),
                      ),
                      child: Text(
                        state.currentWord!.word.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 26 : 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(
                              color: Colors.amber.withOpacity(0.8),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: isSmallScreen ? 16 : 24),

            // Forbidden Words Label
            _buildForbiddenLabel(l10n),

            SizedBox(height: isSmallScreen ? 8 : 12),

            // Forbidden Words List
            Expanded(
              child: _buildForbiddenList(isSmallScreen),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatusBar(bool isSmallScreen) {
    return Row(
      children: [
        // Team Chip
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade700, Colors.teal.shade900],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.groups_rounded,
                    color: Colors.white70, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    state.currentTeam!.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Timer Chip
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: state.remainingTime < 10
                    ? [Colors.red.shade700, Colors.red.shade900]
                    : [Colors.amber.shade700, Colors.amber.shade900],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: (state.remainingTime < 10 ? Colors.red : Colors.amber)
                      .withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.timer_rounded, color: Colors.white, size: 18),
                const SizedBox(width: 6),
                Text(
                  '${state.remainingTime}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForbiddenLabel(AppLocalizations l10n) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_rounded, color: Colors.redAccent, size: 12),
              const SizedBox(width: 6),
              Text(
                l10n.gameForbiddenHeader,
                style: TextStyle(
                  color: Colors.red.shade200,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        const Expanded(child: Divider(indent: 12, color: Colors.white10)),
      ],
    );
  }

  Widget _buildForbiddenList(bool isSmallScreen) {
    return ListView.builder(
      itemCount: state.currentWord!.forbiddenWords.length,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.symmetric(
            vertical: isSmallScreen ? 10 : 14,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.06)),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  state.currentWord!.forbiddenWords[index],
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: isSmallScreen ? 15 : 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Icon(
                Icons.cancel_outlined,
                color: Colors.white.withOpacity(0.15),
                size: 18,
              ),
            ],
          ),
        );
      },
    );
  }
}
