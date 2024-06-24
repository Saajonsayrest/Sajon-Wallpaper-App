import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';

class ProviderLoggingObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) =>
      logMessage('${provider.name} was added.');

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer containers,
  ) =>
      logMessage('${provider.name} was disposed.');

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) =>
      logMessage(
        'Updated ${provider.name} from:',
        extras: {'previousValue': '$hashCode', 'newValue': '$newValue'},
      );

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) =>
      logError(
        'The ${provider.name} failed with: $error',
        stacktrace: stackTrace,
      );
}
