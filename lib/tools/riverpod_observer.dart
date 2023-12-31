import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodObserver implements ProviderObserver {
  const RiverpodObserver();
  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {}

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {}

  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {}

  @override
  void providerDidFail(ProviderBase<Object?> provider, Object error,
      StackTrace stackTrace, ProviderContainer container) {
    debugPrint('Provider $provider \nfailed: $error');
    debugPrint(stackTrace.toString());
  }
}
