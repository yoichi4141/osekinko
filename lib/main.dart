import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'application/providers/router_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: OsekinkoApp(),
    ),
  );
}

class OsekinkoApp extends ConsumerWidget {
  const OsekinkoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'おせき○こゲーム',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Hiragino Sans',
      ),
    );
  }
}
