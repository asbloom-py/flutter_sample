import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_app/resource/notify/provider.dart';

final myObserverRepository =
    Provider<WidgetsBindingObserver>((ref) => MyObserver(ref.read));

class MyObserver implements WidgetsBindingObserver {
  MyObserver(this.read);
  final Reader read;
  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      read(notifyProvider).updateNotifyPermission();
    }

    print('app state now is $state');
  }

  @override
  void didChangeLocales(List<Locale> locales) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<bool> didPopRoute() {
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRoute(String route) {
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    throw UnimplementedError();
  }
}
