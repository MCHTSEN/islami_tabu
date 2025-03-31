import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/game_state_entity.dart';
import '../../presentation/viewmodels/game_viewmodel.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'İslami Tabu Oyunu',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade900,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
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
    );
  }

  Widget _buildGameStatusHeader(GameStateEntity state, double screenWidth) {
    String statusText;
    Color statusColor;

    switch (state.status) {
      case GameStatus.ready:
        statusText = 'Hazır';
        statusColor = Colors.amber;
        break;
      case GameStatus.playing:
        statusText = 'Oyun Devam Ediyor';
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
        // Current Word Card
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_animation.value * 0.05),
              child: child,
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

        // Forbidden Words
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
          child: Container(
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
        ),

        // Score
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade800.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Puan: ${state.score}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGameOverSection(GameStateEntity state, double screenWidth) {
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
                'Oyun Bitti',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Toplam Puan: ${state.score}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade300,
                ),
              ),
              const SizedBox(height: 24),

              // Game Stats
              _buildStatRow('Doğru Bilinen', state.completedWords.length,
                  Colors.green.shade400),
              const SizedBox(height: 8),
              _buildStatRow('Pas Geçilen', state.skippedWords.length,
                  Colors.orange.shade400),
              const SizedBox(height: 8),
              _buildStatRow('Kalan Kelimeler', state.wordsQueue.length,
                  Colors.blue.shade400),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  ref.read(gameViewModelProvider.notifier).restartGame();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Yeniden Oyna',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, int value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 16,
          ),
        ),
        Text(
          '$value',
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildGameControls(GameStateEntity state, double screenWidth) {
    if (state.status == GameStatus.finished) {
      return const SizedBox.shrink();
    }

    if (state.status == GameStatus.ready) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(gameViewModelProvider.notifier).startGame();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Oyunu Başlat',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
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

    // Playing state controls
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Skip Button
        ElevatedButton(
          onPressed: () {
            ref.read(gameViewModelProvider.notifier).skipWord();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.skip_next, size: 24),
              const SizedBox(width: 8),
              Text(
                'Pas (${state.passesUsed}/3)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Pause Button
        IconButton(
          onPressed: () {
            ref.read(gameViewModelProvider.notifier).pauseGame();
          },
          icon: const Icon(
            Icons.pause_circle_filled,
            size: 40,
            color: Colors.white70,
          ),
        ),

        // Correct Button
        ElevatedButton(
          onPressed: () {
            ref.read(gameViewModelProvider.notifier).correctWord();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check, size: 24),
              SizedBox(width: 8),
              Text(
                'Doğru',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
