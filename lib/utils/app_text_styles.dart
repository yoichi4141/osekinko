import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // タイトル用スタイル
  static const TextStyle title = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 2.0,
  );
  
  // サブタイトル用スタイル
  static const TextStyle subtitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );
  
  // ボタンテキスト用スタイル
  static const TextStyle button = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.buttonText,
  );
  
  // 通常テキスト用スタイル
  static const TextStyle body = TextStyle(
    fontSize: 18,
    color: AppColors.primaryText,
  );
  
  // 小さなテキスト用スタイル
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: AppColors.secondaryText,
  );
} 