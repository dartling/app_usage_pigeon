package dev.dartling.app_usage

import androidx.annotation.NonNull
import dev.dartling.app_usage.AppUsage.*

import io.flutter.embedding.engine.plugins.FlutterPlugin

class AppUsagePlugin : FlutterPlugin, AppUsageApi {
    val usedApps: MutableList<UsedApp> = mutableListOf(
        usedApp("com.reddit.app", "Reddit", 75),
        usedApp("dev.hashnode.app", "Hashnode", 37),
        usedApp("link.timelog.app", "Timelog", 25),
    )

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        AppUsageApi.setup(flutterPluginBinding.binaryMessenger, this)
    }

    override fun getPlatformVersion(result: Result<String>?) {
        result?.success("Android ${android.os.Build.VERSION.RELEASE}")
    }

    override fun getApps(result: Result<MutableList<UsedApp>>?) {
        result?.success(usedApps);
    }

    override fun setAppTimeLimit(
        appId: String,
        durationInMinutes: Long,
        result: Result<TimeLimitResult>?
    ) {
        val stateResult = TimeLimitResult.Builder()
            .setState(ResultState.success)
            .setMessage("Timer of $durationInMinutes minutes set for app ID $appId")
            .build()
        result?.success(stateResult)
    }

    private fun usedApp(id: String, name: String, minutesUsed: Long): UsedApp {
        return UsedApp.Builder()
            .setId(id)
            .setName(name)
            .setMinutesUsed(minutesUsed)
            .build();
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        AppUsageApi.setup(binding.binaryMessenger, null)
    }
}