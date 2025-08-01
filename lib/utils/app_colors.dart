import 'package:flutter/material.dart';

class AppColors {
  // 背景色 - 明るくポップな色
  static const Color primaryBackground = Color(0xFFFFF59D); // 明るい黄色
  static const Color secondaryBackground = Color(0xFFFFCDD2); // 明るいピンク
  
  // テキスト色
  static const Color primaryText = Color(0xFF2E2E2E);
  static const Color secondaryText = Color(0xFF666666);
  
  // ボタン色
  static const Color buttonPrimary = Color(0xFFFF7043);
  static const Color buttonSecondary = Color(0xFF66BB6A);
  static const Color buttonText = Colors.white;
  
  // アクセント色
  static const Color accent = Color(0xFFFFAB40);
  
  // グラデーション
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryBackground,
      secondaryBackground,
    ],
  );
} 