import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample_app/resource/notify/provider.dart';

class PermissionChecker extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: ProviderListener<StateController<bool>>(
        provider: notifyPermissionFutureProvider,
        onChange: (context, value) {
          if (!value.state) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text('Notification Permission'),
                  content: const Text(
                      'This app needs notification access to notify'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: const Text('Settings'),
                      onPressed: () {
                        Navigator.pop(context);
                        openAppSettings();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: const SizedBox(width: 1),
      ),
      onWillPop: () async => false,
    );
  }
}
