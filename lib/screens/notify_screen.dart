import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_app/resource/notify/provider.dart';
import 'package:sample_app/widgets/button_notify.dart';

class NotifyScreen extends HookWidget {
  static const String routeName = '/notify';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Text('Tap on a notification when it appears to trigger'
                    ' navigation'),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Did notification launch app? ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              PaddedRaisedButton(
                buttonText: 'Show plain notification with payload',
                onPressed: () async {
                  await context.read(notifyProvider).showNotification(context);
                  return;
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
