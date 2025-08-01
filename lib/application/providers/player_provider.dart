import 'package:flutter_riverpod/flutter_riverpod.dart';

class Player {
  final String name;
  final int id;

  const Player({
    required this.name,
    required this.id,
  });

  Player copyWith({
    String? name,
    int? id,
  }) {
    return Player(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}

class PlayerSetupState {
  final List<Player> players;
  final int minPlayers;
  final int maxPlayers;

  const PlayerSetupState({
    this.players = const [],
    this.minPlayers = 2,
    this.maxPlayers = 6,
  });

  PlayerSetupState copyWith({
    List<Player>? players,
    int? minPlayers,
    int? maxPlayers,
  }) {
    return PlayerSetupState(
      players: players ?? this.players,
      minPlayers: minPlayers ?? this.minPlayers,
      maxPlayers: maxPlayers ?? this.maxPlayers,
    );
  }

  bool get canAddPlayer => players.length < maxPlayers;
  bool get canRemovePlayer => players.length > minPlayers;
  bool get isValidPlayerCount => players.length >= minPlayers;
  
  List<String> get playerNames => players.map((p) => p.name.isNotEmpty ? p.name : 'プレイヤー${p.id}').toList();
}

class PlayerSetupNotifier extends StateNotifier<PlayerSetupState> {
  PlayerSetupNotifier() : super(const PlayerSetupState()) {
    // 初期状態で2人のプレイヤーを追加
    _initializePlayers();
  }

  void _initializePlayers() {
    state = state.copyWith(
      players: [
        const Player(name: '', id: 1),
        const Player(name: '', id: 2),
      ],
    );
  }

  void updatePlayerName(int playerId, String name) {
    final updatedPlayers = state.players.map((player) {
      if (player.id == playerId) {
        return player.copyWith(name: name);
      }
      return player;
    }).toList();

    state = state.copyWith(players: updatedPlayers);
  }

  void addPlayer() {
    if (state.canAddPlayer) {
      final newPlayer = Player(
        name: '',
        id: state.players.length + 1,
      );
      state = state.copyWith(
        players: [...state.players, newPlayer],
      );
    }
  }

  void removePlayer() {
    if (state.canRemovePlayer) {
      final updatedPlayers = state.players.take(state.players.length - 1).toList();
      state = state.copyWith(players: updatedPlayers);
    }
  }

  void resetPlayers() {
    state = const PlayerSetupState();
    _initializePlayers();
  }
}

final playerSetupProvider = StateNotifierProvider<PlayerSetupNotifier, PlayerSetupState>((ref) {
  return PlayerSetupNotifier();
}); 