import 'package:pigeon/pigeon.dart';

enum ResultState { success, error }

class TimeLimitResult {
  final ResultState state;
  final String message;

  TimeLimitResult(this.state, this.message);
}

class UsedApp {
  final String id;
  final String name;
  final int minutesUsed;

  UsedApp(this.id, this.name, this.minutesUsed);
}

@HostApi()
abstract class AppUsageApi {
  @async
  String? getPlatformVersion();

  @async
  List<UsedApp> getApps();

  @async
  TimeLimitResult setAppTimeLimit(String appId, int durationInMinutes);
}
