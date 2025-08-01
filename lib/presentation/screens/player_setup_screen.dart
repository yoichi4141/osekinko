import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../application/providers/player_provider.dart';
import '../../application/providers/app_state_provider.dart';
import '../widgets/custom_button.dart';

class PlayerSetupScreen extends ConsumerWidget {
  const PlayerSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerSetup = ref.watch(playerSetupProvider);
    final playerNotifier = ref.read(playerSetupProvider.notifier);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                
                // タイトル
                Text(
                  'プレイヤー設定',
                  style: AppTextStyles.title.copyWith(fontSize: 36),
                  textAlign: TextAlign.center,
                )
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: -0.2, end: 0),
                
                const SizedBox(height: 10),
                
                // 説明
                Text(
                  '${playerSetup.minPlayers}〜${playerSetup.maxPlayers}人で遊べます',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.primaryText.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 300.ms),
                
                const SizedBox(height: 40),
                
                // プレイヤー入力エリア
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...playerSetup.players.asMap().entries.map((entry) {
                          final index = entry.key;
                          final player = entry.value;
                          
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _PlayerInputField(
                              player: player,
                              onChanged: (name) => playerNotifier.updatePlayerName(player.id, name),
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 400.ms, delay: Duration(milliseconds: 500 + (index * 100)))
                          .slideX(begin: -0.3, end: 0);
                        }).toList(),
                        
                        const SizedBox(height: 20),
                        
                        // プレイヤー追加/削除ボタン
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // プレイヤー削除ボタン
                            CustomButton(
                              text: 'プレイヤー削除',
                              onPressed: playerSetup.canRemovePlayer 
                                ? () => playerNotifier.removePlayer()
                                : null,
                              backgroundColor: playerSetup.canRemovePlayer 
                                ? AppColors.buttonSecondary
                                : Colors.grey,
                              width: 140,
                              height: 50,
                            ),
                            
                            // プレイヤー追加ボタン
                            CustomButton(
                              text: 'プレイヤー追加',
                              onPressed: playerSetup.canAddPlayer 
                                ? () => playerNotifier.addPlayer()
                                : null,
                              backgroundColor: playerSetup.canAddPlayer 
                                ? AppColors.buttonPrimary
                                : Colors.grey,
                              width: 140,
                              height: 50,
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 800.ms),
                      ],
                    ),
                  ),
                ),
                
                // ボタンエリア
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      // スキップボタン
                      CustomButton(
                        text: 'スキップ（2人で開始）',
                        onPressed: () {
                          playerNotifier.resetPlayers();
                          final appNotifier = ref.read(appStateProvider.notifier);
                          appNotifier.startGame(['プレイヤー1', 'プレイヤー2']);
                          context.go('/game');
                        },
                        backgroundColor: AppColors.buttonSecondary,
                        width: 280,
                        height: 60,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // ゲーム開始ボタン
                      CustomButton(
                        text: 'ゲーム開始',
                        onPressed: playerSetup.isValidPlayerCount 
                          ? () {
                              final appNotifier = ref.read(appStateProvider.notifier);
                              appNotifier.startGame(playerSetup.playerNames);
                              context.go('/game');
                            }
                          : null,
                        backgroundColor: playerSetup.isValidPlayerCount 
                          ? AppColors.buttonPrimary
                          : Colors.grey,
                        width: 280,
                        height: 60,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // 戻るボタン
                      TextButton(
                        onPressed: () => context.go('/'),
                        child: Text(
                          '戻る',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.primaryText.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 1000.ms)
                .slideY(begin: 0.3, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayerInputField extends StatelessWidget {
  final Player player;
  final ValueChanged<String> onChanged;

  const _PlayerInputField({
    required this.player,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                '${player.id}',
                style: AppTextStyles.button.copyWith(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: AppTextStyles.body,
              decoration: InputDecoration(
                hintText: 'プレイヤー${player.id}',
                hintStyle: AppTextStyles.body.copyWith(
                  color: AppColors.secondaryText,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 