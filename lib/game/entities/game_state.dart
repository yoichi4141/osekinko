import 'package:flutter_riverpod/flutter_riverpod.dart';

enum GamePhase {
  preparation,    // 準備段階
  osechiAnimation, // おせち×2 アニメーション
  osekinkoAnimation, // おせきんこ アニメーション  
  playerSelection, // プレイヤー選択表示
  phraseDisplay,   // フレーズ表示
  timer,          // タイマー中
  nextTurn,       // 次ターンへ
  gameEnd,        // ゲーム終了
}

enum OsekinkoPhrase {
  osekinko('おせき○こ', 'おせきんこ'),
  osekinpo('おせき○ポ', 'おせきんポ'),
  osekintyu('おせき○ちゅう', 'おせきんちゅう');

  const OsekinkoPhrase(this.displayText, this.fullText);
  
  final String displayText; // 画面表示用（伏せ字）
  final String fullText;   // 実際の値（音声用）
}

class GameState {
  final GamePhase phase;
  final List<String> players;
  final int currentPlayerIndex;
  final String? selectedPlayer;
  final OsekinkoPhrase? currentPhrase;
  final int remainingTime;
  final int turnCount;
  final bool isGameActive;

  const GameState({
    this.phase = GamePhase.preparation,
    this.players = const [],
    this.currentPlayerIndex = 0,
    this.selectedPlayer,
    this.currentPhrase,
    this.remainingTime = 5,
    this.turnCount = 0,
    this.isGameActive = false,
  });

  GameState copyWith({
    GamePhase? phase,
    List<String>? players,
    int? currentPlayerIndex,
    String? selectedPlayer,
    OsekinkoPhrase? currentPhrase,
    int? remainingTime,
    int? turnCount,
    bool? isGameActive,
  }) {
    return GameState(
      phase: phase ?? this.phase,
      players: players ?? this.players,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
      selectedPlayer: selectedPlayer ?? this.selectedPlayer,
      currentPhrase: currentPhrase ?? this.currentPhrase,
      remainingTime: remainingTime ?? this.remainingTime,
      turnCount: turnCount ?? this.turnCount,
      isGameActive: isGameActive ?? this.isGameActive,
    );
  }

  String get currentPlayerName => 
    players.isNotEmpty ? players[currentPlayerIndex] : '';
    
  bool get hasNextPlayer => currentPlayerIndex < players.length - 1;
} 