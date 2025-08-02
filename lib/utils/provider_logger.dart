import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print(
        '🟢 Provider added: ${provider.name ?? provider.runtimeType}, value: $value',
      );
    }
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print(
        '🟡 Provider updated: ${provider.name ?? provider.runtimeType}, new value: $newValue',
      );
    }
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    if (kDebugMode) {
      print('🔴 Provider disposed: ${provider.name ?? provider.runtimeType}');
    }
  }
}
