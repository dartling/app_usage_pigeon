
import 'app_usage_platform_interface.dart';

class AppUsage {
  Future<String?> getPlatformVersion() {
    return AppUsagePlatform.instance.getPlatformVersion();
  }
}
