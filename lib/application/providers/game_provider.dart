import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../game/entities/game_state.dart';

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier() : super(const GameState());
  
  Timer? _gameTimer;
  Timer? _phaseTimer;

  @override
  void dispose() {
    _gameTimer?.cancel();
    _phaseTimer?.cancel();
    super.dispose();
  }

  void startGame(List<String> players) {
    state = GameState(
      phase: GamePhase.preparation,
      players: players,
      currentPlayerIndex: 0,
      turnCount: 0,
      isGameActive: true,
    );
    
    // ゲーム開始のアニメーションシーケンスを開始
    _startAnimationSequence();
  }

  void _startAnimationSequence() {
    // 1. おせち×2 アニメーション (1秒)
    state = state.copyWith(phase: GamePhase.osechiAnimation);
    
    _phaseTimer = Timer(const Duration(seconds: 1), () {
      // 2. おせきんこ アニメーション (0.5秒)
      state = state.copyWith(phase: GamePhase.osekinkoAnimation);
      
      _phaseTimer = Timer(const Duration(milliseconds: 500), () {
        // 3. プレイヤー選択
        _selectRandomPlayer();
      });
    });
  }

  void _selectRandomPlayer() {
    final random = Random();
    final selectedIndex = random.nextInt(state.players.length);
    final selectedPlayer = state.players[selectedIndex];
    
    state = state.copyWith(
      phase: GamePhase.playerSelection,
      selectedPlayer: selectedPlayer,
    );
    
    // 0.5秒後にフレーズ表示
    _phaseTimer = Timer(const Duration(milliseconds: 500), () {
      _showRandomPhrase();
    });
  }

  void _showRandomPhrase() {
    final random = Random();
    final phrases = OsekinkoPhrase.values;
    final selectedPhrase = phrases[random.nextInt(phrases.length)];
    
    state = state.copyWith(
      phase: GamePhase.phraseDisplay,
      currentPhrase: selectedPhrase,
    );
    
    // 0.5秒後にタイマー開始
    _phaseTimer = Timer(const Duration(milliseconds: 500), () {
      _startTimer();
    });
  }

  void _startTimer() {
    state = state.copyWith(
      phase: GamePhase.timer,
      remainingTime: 5,
    );
    
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingTime > 1) {
        state = state.copyWith(remainingTime: state.remainingTime - 1);
      } else {
        timer.cancel();
        _nextTurn();
      }
    });
  }

  void _nextTurn() {
    _gameTimer?.cancel();
    
    state = state.copyWith(
      phase: GamePhase.nextTurn,
      turnCount: state.turnCount + 1,
    );
    
    // 1秒後に次のターンを開始
    _phaseTimer = Timer(const Duration(seconds: 1), () {
      _startAnimationSequence();
    });
  }

  void endGame() {
    _gameTimer?.cancel();
    _phaseTimer?.cancel();
    
    state = state.copyWith(
      phase: GamePhase.gameEnd,
      isGameActive: false,
    );
  }

  void resetGame() {
    _gameTimer?.cancel();
    _phaseTimer?.cancel();
    state = const GameState();
  }

  void forceNextTurn() {
    _gameTimer?.cancel();
    _nextTurn();
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier();
}); 