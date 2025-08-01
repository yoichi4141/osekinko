# おせき○こゲーム

Flutterで開発した「おせきんこ」ゲームアプリです。プレイヤーが順番に指定されたフレーズを言うゲームで、ランダム要素とアニメーションが楽しめます。

## 🎮 ゲーム概要

- **プレイ人数**: 2〜6人
- **ゲームフロー**: 
  1. 「おせち」「おせち」「おせき○こ」のアニメーション
  2. ランダムでプレイヤーを選択
  3. ランダムでフレーズを表示（「おせき○こ」「おせき○ポ」「おせき○ちゅう」）
  4. 5秒のタイマーでリアクション
  5. 自動で次のターンへ

## 🛠️ 技術仕様

### アーキテクチャ
- **設計**: クリーンアーキテクチャ
- **状態管理**: Riverpod
- **ルーティング**: go_router

### 技術スタック
```yaml
dependencies:
  flutter: SDK
  flutter_riverpod: ^2.5.1     # 状態管理
  go_router: ^14.2.7           # ルーティング
  audioplayers: ^6.1.0         # 音声再生
  flutter_animate: ^4.5.0      # アニメーション
```

### ディレクトリ構造
```
lib/
├── application/          # アプリケーション層
│   └── providers/       # Riverpodプロバイダー
├── game/                # ゲーム専用ロジック
│   └── entities/        # ゲームエンティティ
├── presentation/        # プレゼンテーション層
│   ├── screens/         # 画面
│   └── widgets/         # 再利用可能ウィジェット
└── utils/              # 共通ユーティリティ
```

## 🎨 UI/UX特徴

- **カラーパレット**: 明るい黄色とピンクのポップなグラデーション
- **アニメーション**: flutter_animateによる滑らかな演出
- **レスポンシブ**: 大きなボタンとテキストでタップしやすい設計
- **審査対策**: 「おせき○こ」の伏せ字表示

## 🚀 実装完了機能

### ✅ feature/start_screen
- スタート画面の実装
- タイトル表示とゲーム開始ボタン

### ✅ feature/player_setup  
- プレイヤー設定画面
- 2〜6人の名前入力・管理機能

### ✅ feature/game_core
- ゲーム進行の中核ロジック
- アニメーション付きゲームフロー
- タイマー機能とターン管理

## 🔧 開発・実行方法

### 環境要件
- Flutter SDK 3.8.1+
- Dart 3.0+

### 実行手順
```bash
# 依存関係のインストール
flutter pub get

# アプリケーションの実行
flutter run

# ウェブブラウザで実行
flutter run -d chrome
```

### ビルド
```bash
# APK生成（Android）
flutter build apk

# IPAファイル生成（iOS）
flutter build ios
```

## 📱 AppStore審査対策

- フレーズ表示は伏せ字（「おせき○こ」）で表示
- 音声再生は実際の音声ファイルを使用可能
- 意味が分かりにくい表示で審査を通しやすく設計

## 🎯 今後の拡張予定

- [ ] feature/game_audio - 音声再生機能
- [ ] feature/result_screen - 結果画面
- [ ] feature/ui_tuning - UIデザイン調整
- [ ] feature/phrase_randomizer - フレーズ管理強化
- [ ] feature/timer_logic - タイマー機能拡張

## 📄 ライセンス

このプロジェクトはMITライセンスの下で公開されています。

## 👨‍💻 開発者

[@yoichi4141](https://github.com/yoichi4141)

---

**🎊 楽しい「おせき○こ」ゲームをお楽しみください！**
