import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionProvider = Provider((ref) => PermissionProvider(ref.read));

class PermissionProvider {
  PermissionProvider(this.read);
  final Reader read;

  Future<bool> initState() async {
    final l = await check();
    print(l);
    return l;
  }

  Future<bool> check() async {
    final notify = await Permission.notification.isGranted;
    if (!notify) {
      return false;
    } else {
      return true;
    }
  }

  void dispose() {
    return;
  }
}
