import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                
                // メインタイトル - 伏せ字で表示（審査対策）
                Text(
                  'おせき○こ',
                  style: AppTextStyles.title,
                  textAlign: TextAlign.center,
                )
                .animate()
                .fadeIn(duration: 800.ms, delay: 200.ms)
                .slideY(begin: 0.3, end: 0),
                
                const SizedBox(height: 20),
                
                // サブタイトル
                Text(
                  'ゲーム',
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.accent,
                  ),
                  textAlign: TextAlign.center,
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 800.ms)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),
                
                const Spacer(flex: 2),
                
                // ゲームスタートボタン
                CustomButton(
                  text: 'ゲームスタート',
                  onPressed: () {
                    // TODO: プレイヤー設定画面またはゲーム画面への遷移
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('ゲーム開始！'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  width: 300,
                  height: 70,
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 1200.ms)
                .slideY(begin: 0.2, end: 0),
                
                const SizedBox(height: 40),
                
                // 説明テキスト
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'タップしてスタート！',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 16,
                      color: AppColors.primaryText.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 1600.ms),
                
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 