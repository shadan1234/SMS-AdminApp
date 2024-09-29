import 'package:permission_handler/permission_handler.dart';

Future<void> requestSmsPermission() async {
  var status = await Permission.sms.status;
  if (!status.isGranted) {
    await Permission.sms.request();
  }
}

Future<void> requestPhoneStatePermission() async {
  var status = await Permission.phone.status;
  if (!status.isGranted) {
    await Permission.phone.request();
  }
}

Future<void> requestAllPermissions() async {
  await requestSmsPermission();
  await requestPhoneStatePermission();
}
