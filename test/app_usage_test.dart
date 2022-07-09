import 'package:flutter_test/flutter_test.dart';
import 'package:app_usage/app_usage.dart';
import 'package:app_usage/app_usage_platform_interface.dart';
import 'package:app_usage/app_usage_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppUsagePlatform 
    with MockPlatformInterfaceMixin
    implements AppUsagePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AppUsagePlatform initialPlatform = AppUsagePlatform.instance;

  test('$MethodChannelAppUsage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppUsage>());
  });

  test('getPlatformVersion', () async {
    AppUsage appUsagePlugin = AppUsage();
    MockAppUsagePlatform fakePlatform = MockAppUsagePlatform();
    AppUsagePlatform.instance = fakePlatform;
  
    expect(await appUsagePlugin.getPlatformVersion(), '42');
  });
}
