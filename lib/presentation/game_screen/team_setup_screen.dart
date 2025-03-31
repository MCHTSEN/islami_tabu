import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/team_entity.dart';
import '../viewmodels/game_viewmodel.dart';

class TeamSetupScreen extends ConsumerStatefulWidget {
  const TeamSetupScreen({super.key});

  @override
  ConsumerState<TeamSetupScreen> createState() => _TeamSetupScreenState();
}

class _TeamSetupScreenState extends ConsumerState<TeamSetupScreen> {
  int _teamCount = 2;
  final List<TeamEntity> _teams = [];

  @override
  void initState() {
    super.initState();
    _initializeTeams();
  }

  void _initializeTeams() {
    _teams.clear();
    for (int i = 0; i < _teamCount; i++) {
      _teams.add(TeamEntity(name: '${i + 1}. Takım'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Team Count Selector
                Text(
                  'Takım Sayısı',
                  style: TextStyle(
                    color: Colors.amber.shade300,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade800.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.white),
                        onPressed: _teamCount > 2
                            ? () {
                                setState(() {
                                  _teamCount--;
                                  _initializeTeams();
                                });
                              }
                            : null,
                      ),
                      Text(
                        '$_teamCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: _teamCount < 8
                            ? () {
                                setState(() {
                                  _teamCount++;
                                  _initializeTeams();
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Team List
                Expanded(
                  child: ListView.builder(
                    itemCount: _teams.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade800.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.amber.shade700.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.group,
                              color: Colors.amber.shade300,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              _teams[index].name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Start Game Button
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(gameViewModelProvider.notifier).setTeams(_teams);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Oyunu Başlat',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
