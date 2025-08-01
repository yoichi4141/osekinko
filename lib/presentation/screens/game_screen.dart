import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../application/providers/game_provider.dart';
import '../../game/entities/game_state.dart';
import '../widgets/custom_button.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ヘッダー
              _GameHeader(
                turnCount: gameState.turnCount,
                onEndGame: () {
                  gameNotifier.endGame();
                  context.go('/');
                },
              ),
              
              // メインゲームエリア
              Expanded(
                child: _GameMainArea(gameState: gameState),
              ),
              
              // フッター（デバッグ用コントロール）
              if (gameState.isGameActive)
                _GameFooter(
                  onNextTurn: () => gameNotifier.forceNextTurn(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GameHeader extends StatelessWidget {
  final int turnCount;
  final VoidCallback onEndGame;

  const _GameHeader({
    required this.turnCount,
    required this.onEndGame,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ターン ${turnCount + 1}',
            style: AppTextStyles.subtitle,
          ),
          TextButton(
            onPressed: onEndGame,
            child: Text(
              '終了',
              style: AppTextStyles.body.copyWith(
                color: AppColors.primaryText.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GameMainArea extends StatelessWidget {
  final GameState gameState;

  const _GameMainArea({required this.gameState});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPhaseDisplay(),
          const SizedBox(height: 40),
          _buildTimerDisplay(),
        ],
      ),
    );
  }

  Widget _buildPhaseDisplay() {
    switch (gameState.phase) {
      case GamePhase.preparation:
        return Text(
          '準備中...',
          style: AppTextStyles.title.copyWith(fontSize: 36),
        );
        
      case GamePhase.osechiAnimation:
        return Column(
          children: [
            Text(
              'おせち',
              style: AppTextStyles.title,
            )
            .animate()
            .fadeIn(duration: 300.ms)
            .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0)),
            
            const SizedBox(height: 20),
            
            Text(
              'おせち',
              style: AppTextStyles.title,
            )
            .animate()
            .fadeIn(duration: 300.ms, delay: 500.ms)
            .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0)),
          ],
        );
        
      case GamePhase.osekinkoAnimation:
        return Text(
          'おせき○こ',
          style: AppTextStyles.title.copyWith(
            color: AppColors.buttonPrimary,
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2))
        .then()
        .scale(begin: const Offset(1.2, 1.2), end: const Offset(1.0, 1.0));
        
      case GamePhase.playerSelection:
        return Column(
          children: [
            Text(
              '選ばれたプレイヤー:',
              style: AppTextStyles.subtitle,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                gameState.selectedPlayer ?? '',
                style: AppTextStyles.title.copyWith(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.3, end: 0),
          ],
        );
        
      case GamePhase.phraseDisplay:
        return Column(
          children: [
            Text(
              '言ってもらう言葉:',
              style: AppTextStyles.subtitle,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.buttonPrimary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                gameState.currentPhrase?.displayText ?? '',
                style: AppTextStyles.title.copyWith(
                  color: Colors.white,
                  fontSize: 42,
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 600.ms)
            .scale(begin: const Offset(0.7, 0.7), end: const Offset(1.0, 1.0)),
          ],
        );
        
      case GamePhase.timer:
        return Column(
          children: [
            Text(
              gameState.selectedPlayer ?? '',
              style: AppTextStyles.subtitle.copyWith(
                color: AppColors.primaryText.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              gameState.currentPhrase?.displayText ?? '',
              style: AppTextStyles.title.copyWith(
                fontSize: 36,
                color: AppColors.buttonPrimary,
              ),
            ),
          ],
        );
        
      case GamePhase.nextTurn:
        return Text(
          '次のターンへ...',
          style: AppTextStyles.title.copyWith(fontSize: 36),
        )
        .animate()
        .fadeIn(duration: 500.ms);
        
      case GamePhase.gameEnd:
        return Text(
          'ゲーム終了！',
          style: AppTextStyles.title.copyWith(
            color: AppColors.buttonPrimary,
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms)
        .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0));
    }
  }

  Widget _buildTimerDisplay() {
    if (gameState.phase == GamePhase.timer) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: gameState.remainingTime <= 2 
            ? Colors.red
            : AppColors.buttonSecondary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '${gameState.remainingTime}',
            style: AppTextStyles.title.copyWith(
              color: Colors.white,
              fontSize: 48,
            ),
          ),
        ),
      )
      .animate()
      .scale(
        duration: 1000.ms,
        begin: const Offset(1.0, 1.0),
        end: const Offset(1.1, 1.1),
      )
      .then()
      .scale(
        duration: 1000.ms,
        begin: const Offset(1.1, 1.1),
        end: const Offset(1.0, 1.0),
      );
    }
    return const SizedBox.shrink();
  }
}

class _GameFooter extends StatelessWidget {
  final VoidCallback onNextTurn;

  const _GameFooter({required this.onNextTurn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomButton(
        text: '次のターンへ',
        onPressed: onNextTurn,
        backgroundColor: AppColors.buttonSecondary,
        width: 200,
        height: 50,
      ),
    );
  }
} 