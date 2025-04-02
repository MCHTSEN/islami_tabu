import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islami_tabu/core/helper/gap.dart';
import 'dart:ui';
import '../../domain/entities/game_state_entity.dart';
import '../../presentation/viewmodels/game_viewmodel.dart';
import 'team_setup_screen.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameViewModelProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitConfirmationDialog(context);
        if (shouldPop) {
          ref.read(gameViewModelProvider.notifier).restartGame();
        }
        return shouldPop;
      },
      child: Scaffold(
        appBar: AppBar(
          title: gameState.whenData((state) {
                if (state.status == GameStatus.playing ||
                    state.status == GameStatus.paused) {
                  // Show team name and score in playing mode
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Team name
                      Expanded(
                        child: Text(
                          state.currentTeam.name,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Score badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade700,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${state.currentTeam.score}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  // Default title
                  return const Text(
                    'İslami Tabu Oyunu',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  );
                }
              }).value ??
              const Text(
                'İslami Tabu Oyunu',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
          backgroundColor: Colors.teal.shade900,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              final shouldExit = await _showExitConfirmationDialog(context);
              if (shouldExit) {
                ref.read(gameViewModelProvider.notifier).restartGame();
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: Container(
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
          child: gameState.when(
            data: (state) {
              // Show team setup screen if in setup status
              if (state.status == GameStatus.setup) {
                return const TeamSetupScreen();
              }

              // Set animation state based on game status
              if (state.status == GameStatus.playing) {
                _animationController.repeat(reverse: true);
              } else {
                _animationController.stop();
                if (state.status == GameStatus.paused ||
                    state.status == GameStatus.finished) {
                  _animationController.value = 1.0;
                } else {
                  _animationController.value = 0.0;
                }
              }

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Game Status and Timer
                      _buildGameStatusHeader(state, screenWidth),
                      SizedBox(height: screenHeight * 0.03),

                      // Main Game Content
                      Expanded(
                        child: state.status == GameStatus.finished
                            ? _buildGameOverSection(state, screenWidth)
                            : _buildGamePlaySection(state, screenWidth),
                      ),
                      Gap.normal,
                      // Game Controls
                      _buildGameControls(state, screenWidth),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
            error: (error, stackTrace) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SelectableText.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Bir hata oluştu: ',
                        style: TextStyle(color: Colors.red.shade300),
                      ),
                      TextSpan(
                        text: '$error',
                        style: TextStyle(
                            color: Colors.red.shade300,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameStatusHeader(GameStateEntity state, double screenWidth) {
    String statusText;
    Color statusColor;

    switch (state.status) {
      case GameStatus.setup:
        statusText = 'Takım Seçimi';
        statusColor = Colors.blue;
        break;
      case GameStatus.ready:
        statusText = '${state.currentTeam.name} Hazır';
        statusColor = Colors.amber;
        break;
      case GameStatus.playing:
        statusText = '${state.currentTeam.name} Oynuyor';
        statusColor = Colors.green;
        break;
      case GameStatus.paused:
        statusText = 'Duraklatıldı';
        statusColor = Colors.orange;
        break;
      case GameStatus.finished:
        statusText = 'Oyun Bitti';
        statusColor = Colors.red;
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Game Status
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade800.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: statusColor.withOpacity(0.7),
              width: 2,
            ),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        // Timer
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade800.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.amber.withOpacity(0.7),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.timer,
                color: Colors.amber,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${state.remainingTime}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGamePlaySection(GameStateEntity state, double screenWidth) {
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
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_animation.value * 0.05),
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

  Widget _buildGameOverSection(GameStateEntity state, double screenWidth) {
    // Sort teams by score in descending order
    final sortedTeams = List.from(state.teams)
      ..sort((a, b) => b.score.compareTo(a.score));

    return Center(
      child: Card(
        color: Colors.blueGrey.shade900.withOpacity(0.7),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.amber.shade700, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Puan Tablosu',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // Team Scores
              ...sortedTeams.map((team) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          team.name,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        Text(
                          '${team.score} puan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: team == sortedTeams.first
                                ? Colors.amber.shade300
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Exit Button
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(gameViewModelProvider.notifier).restartGame();
                    },
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text('Çıkış'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Continue Button
                  ElevatedButton.icon(
                    onPressed: () {
                      ref
                          .read(gameViewModelProvider.notifier)
                          .continueGameAfterScores();
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Devam Et'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameControls(GameStateEntity state, double screenWidth) {
    if (state.status == GameStatus.finished) {
      return const SizedBox.shrink();
    }

    if (state.status == GameStatus.ready) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${state.currentTeam.name} Hazır mısın?',
              style: TextStyle(
                color: Colors.amber.shade300,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ref.read(gameViewModelProvider.notifier).startGame();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Başla',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }

    if (state.status == GameStatus.paused) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(gameViewModelProvider.notifier).startGame();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Devam Et',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    // Playing state controls - row of three buttons
    return Row(
      children: [
        // Skip Button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildControlButton(
              onPressed: () {
                ref.read(gameViewModelProvider.notifier).skipWord();
              },
              icon: Icons.skip_next,
              label: 'Pas (${state.passesUsed}/3)',
              color: Colors.orange.shade700,
            ),
          ),
        ),

        // Tabu Button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildControlButton(
              onPressed: () {
                ref.read(gameViewModelProvider.notifier).tabuWord();
              },
              icon: Icons.block,
              label: 'Tabu',
              color: Colors.purple.shade700,
            ),
          ),
        ),

        // Correct Button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildControlButton(
              onPressed: () {
                ref.read(gameViewModelProvider.notifier).correctWord();
              },
              icon: Icons.check,
              label: 'Doğru',
              color: Colors.green.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Show exit confirmation dialog
  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.blueGrey.shade900,
            title: const Text(
              'Oyundan Çıkış',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'Oyundan çıkmak istediğinize emin misiniz? Tüm oyun parametreleri sıfırlanacak.',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Hayır',
                  style: TextStyle(color: Colors.amber.shade300),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Evet, Çık'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
