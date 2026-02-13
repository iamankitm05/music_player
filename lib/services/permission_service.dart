import 'package:photo_manager/photo_manager.dart';

class PermissionService {
  Future<bool> checkPermission() async {
    final ps = await PhotoManager.getPermissionState(
      requestOption: PermissionRequestOption(
        androidPermission: AndroidPermission(
          type: RequestType.audio,
          mediaLocation: true,
        ),
      ),
    );
    return ps.isAuth;
  }

  Future<bool> requestPermission() async {
    PermissionState ps = await PhotoManager.requestPermissionExtend(
      requestOption: PermissionRequestOption(
        androidPermission: AndroidPermission(
          type: RequestType.audio,
          mediaLocation: true,
        ),
      ),
    );
    if (ps.isAuth) return true;

    await PhotoManager.openSetting();
    return checkPermission();
  }
}
