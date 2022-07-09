import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_usage/app_usage_method_channel.dart';

void main() {
  MethodChannelAppUsage platform = MethodChannelAppUsage();
  const MethodChannel channel = MethodChannel('app_usage');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
