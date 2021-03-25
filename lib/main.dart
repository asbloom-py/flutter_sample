import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_app/second_screen.dart';
import 'package:sample_app/resource/global/provider.dart';
import 'package:sample_app/rootpage.dart';

Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final navKey = useProvider(navKeyProvider);
    return MaterialApp(
      initialRoute: '/',
      navigatorKey: navKey,
      routes: <String, WidgetBuilder>{
        '/': (_) => RootScreen(),
        SecondScreen.routeName: (_) => SecondScreen()
      },
    );
  }
}
