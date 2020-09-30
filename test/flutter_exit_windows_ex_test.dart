import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:flutter_exit_windows_ex/flutter_exit_windows_ex.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_exit_windows_ex');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    //expect(await FlutterExitWindowsEx.platformVersion, '42');
  });
}
