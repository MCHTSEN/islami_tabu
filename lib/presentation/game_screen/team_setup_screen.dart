import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islami_tabu/l10n/generated/app_localizations.dart';

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
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _initializeTeams(context);
      _isInitialized = true;
    }
  }

  void _initializeTeams(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    _teams.clear();
    for (int i = 0; i < _teamCount; i++) {
      _teams.add(TeamEntity(name: l10n.teamSetupDefaultName(i + 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          Text(
            l10n.teamSetupTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 32),

          // Team Count Selector
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              children: [
                Text(
                  l10n.teamSetupHowMany,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCountButton(
                      icon: Icons.remove_rounded,
                      onTap: _teamCount > 2
                          ? () {
                              setState(() {
                                _teamCount--;
                                _initializeTeams(context);
                              });
                            }
                          : null,
                    ),
                    const SizedBox(width: 24),
                    Text(
                      '$_teamCount',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 24),
                    _buildCountButton(
                      icon: Icons.add_rounded,
                      onTap: _teamCount < 8
                          ? () {
                              setState(() {
                                _teamCount++;
                                _initializeTeams(context);
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Team List
          Expanded(
            child: ListView.builder(
              itemCount: _teams.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.08),
                        Colors.white.withOpacity(0.02),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.amber.withOpacity(0.2),
                        radius: 12,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        _teams[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.edit_rounded,
                          color: Colors.white.withOpacity(0.2), size: 16),
                    ],
                  ),
                );
              },
            ),
          ),

          // Start Game Button
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              ref.read(gameViewModelProvider.notifier).setTeams(_teams);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.amber, Color(0xFFFF8F00)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Text(
                l10n.gameReadyStart,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildCountButton({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: onTap != null
              ? Colors.white.withOpacity(0.1)
              : Colors.white.withOpacity(0.01),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Icon(
          icon,
          color: onTap != null ? Colors.white : Colors.white24,
          size: 24,
        ),
      ),
    );
  }
}
