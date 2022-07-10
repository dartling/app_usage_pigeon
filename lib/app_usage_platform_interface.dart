import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_usage_api.dart';
import 'app_usage_pigeon.dart';

abstract class AppUsagePlatform extends PlatformInterface {
  /// Constructs a AppUsagePlatform.
  AppUsagePlatform() : super(token: _token);

  static final Object _token = Object();

  static AppUsagePlatform _instance = PigeonAppUsage();

  /// The default instance of [AppUsagePlatform] to use.
  ///
  /// Defaults to [PigeonAppUsage].
  static AppUsagePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppUsagePlatform] when
  /// they register themselves.
  static set instance(AppUsagePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<UsedApp>> get apps async {
    throw UnimplementedError('apps has not been implemented.');
  }

  Future<TimeLimitResult> setAppTimeLimit(String appId, Duration duration) async {
    throw UnimplementedError('setAppTimeLimit() has not been implemented.');
  }
}
