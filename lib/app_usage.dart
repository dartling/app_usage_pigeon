import 'app_usage_api.dart';
import 'app_usage_platform_interface.dart';

class AppUsage {
  Future<String?> getPlatformVersion() {
    return AppUsagePlatform.instance.getPlatformVersion();
  }

  Future<List<UsedApp>> get apps {
    return AppUsagePlatform.instance.apps;
  }

  Future<TimeLimitResult> setAppTimeLimit(String appId, Duration duration) {
    return AppUsagePlatform.instance.setAppTimeLimit(appId, duration);
  }
}
