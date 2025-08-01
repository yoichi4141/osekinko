import 'package:flutter_riverpod/flutter_riverpod.dart';

// アプリの基本的な状態管理
class AppState {
  final bool isGameStarted;
  final List<String> players;
  final int currentPlayerIndex;

  const AppState({
    this.isGameStarted = false,
    this.players = const [],
    this.currentPlayerIndex = 0,
  });

  AppState copyWith({
    bool? isGameStarted,
    List<String>? players,
    int? currentPlayerIndex,
  }) {
    return AppState(
      isGameStarted: isGameStarted ?? this.isGameStarted,
      players: players ?? this.players,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState());

  void startGame(List<String> players) {
    state = state.copyWith(
      isGameStarted: true,
      players: players,
      currentPlayerIndex: 0,
    );
  }

  void endGame() {
    state = state.copyWith(
      isGameStarted: false,
      players: [],
      currentPlayerIndex: 0,
    );
  }

  void nextPlayer() {
    if (state.players.isNotEmpty) {
      state = state.copyWith(
        currentPlayerIndex: (state.currentPlayerIndex + 1) % state.players.length,
      );
    }
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
}); 