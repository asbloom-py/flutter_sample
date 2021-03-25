import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_app/notify_screen.dart';
import 'package:sample_app/resource/notify/provider.dart';
import 'package:sample_app/resource/notify/widget_observer.dart';
import 'package:sample_app/widgets/permission_check.dart';

class RootScreen extends HookWidget {
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {
    // ignore: void_checks
    useEffect(() {
      final observer = context.read(myObserverRepository);
      WidgetsBinding.instance.addObserver(observer);
      context.read<NotifyProvider>(notifyProvider).initState();
      return () => WidgetsBinding.instance.removeObserver(observer);
    }, const []);
    return MaterialApp(
      home: Scaffold(
        body: Container(
            child: Stack(
          children: [
            NotifyScreen(),
            PermissionChecker(),
          ],
        )),
      ),
    );
  }
}
