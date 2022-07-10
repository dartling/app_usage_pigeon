import 'package:app_usage/app_usage_api.dart';
import 'package:app_usage/app_usage_pigeon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_usage/app_usage.dart';
import 'package:app_usage/app_usage_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppUsagePlatform
    with MockPlatformInterfaceMixin
    implements AppUsagePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<List<UsedApp>> get apps async =>
      [UsedApp(id: "id", name: "name", minutesUsed: 60)];

  @override
  Future<TimeLimitResult> setAppTimeLimit(
      String appId, Duration duration) async {
    return TimeLimitResult(state: ResultState.success, message: "Success");
  }
}

void main() {
  final AppUsagePlatform initialPlatform = AppUsagePlatform.instance;

  test('$PigeonAppUsage is the default instance', () {
    expect(initialPlatform, isInstanceOf<PigeonAppUsage>());
  });

  test('getPlatformVersion', () async {
    AppUsage appUsagePlugin = AppUsage();
    MockAppUsagePlatform fakePlatform = MockAppUsagePlatform();
    AppUsagePlatform.instance = fakePlatform;

    expect(await appUsagePlugin.getPlatformVersion(), '42');
  });

  test('getPlatformVersion', () async {
    AppUsage appUsagePlugin = AppUsage();
    MockAppUsagePlatform fakePlatform = MockAppUsagePlatform();
    AppUsagePlatform.instance = fakePlatform;

    final apps = await appUsagePlugin.apps;
    expect(apps.length, 1);
    expect(apps.first.id, "id");
    expect(apps.first.name, "name");
    expect(apps.first.minutesUsed, 60);
  });

  test('getPlatformVersion', () async {
    AppUsage appUsagePlugin = AppUsage();
    MockAppUsagePlatform fakePlatform = MockAppUsagePlatform();
    AppUsagePlatform.instance = fakePlatform;

    final result = await appUsagePlugin.setAppTimeLimit("id", Duration.zero);
    expect(result.state, ResultState.success);
    expect(result.message, "Success");
  });
}
