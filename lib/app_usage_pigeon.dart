import 'package:app_usage/app_usage_platform_interface.dart';

import 'app_usage_api.dart';

/// An implementation of [AppUsagePlatform] that uses Pigeon.
class PigeonAppUsage extends AppUsagePlatform {
  final AppUsageApi _api = AppUsageApi();

  @override
  Future<String?> getPlatformVersion() {
    return _api.getPlatformVersion();
  }

  @override
  Future<List<UsedApp>> get apps {
    return _api
        .getApps()
        .then((apps) => apps.where((e) => e != null).map((e) => e!).toList());
  }

  @override
  Future<TimeLimitResult> setAppTimeLimit(String appId, Duration duration) async {
    return _api.setAppTimeLimit(appId, duration.inMinutes);
  }
}
