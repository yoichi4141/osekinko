import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/start_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'start',
        builder: (context, state) => const StartScreen(),
      ),
      // TODO: 他の画面のルートを追加
      // GoRoute(
      //   path: '/player-setup',
      //   name: 'player-setup',
      //   builder: (context, state) => const PlayerSetupScreen(),
      // ),
      // GoRoute(
      //   path: '/game',
      //   name: 'game',
      //   builder: (context, state) => const GameScreen(),
      // ),
    ],
    errorBuilder: (context, state) => const StartScreen(),
  );
}); 