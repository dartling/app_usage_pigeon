import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_usage_platform_interface.dart';

/// An implementation of [AppUsagePlatform] that uses method channels.
class MethodChannelAppUsage extends AppUsagePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_usage');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
